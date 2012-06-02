module WCF
  module Components

    # Base class for Forge containers on page.
    # Containers can have other containers or elements inside.
    class DwrContainer < Container

      # Uses {Container#initialize} with additional locator generation options.
      # @param [String, Symbol] how locator if String, initialization modifier if Symbol (:class, :id, :locator).
      # @param [String, nil] what initialization additional information for modifier.
      def initialize(how, what = nil)
        if (not what.nil?)
          case how
            when :id, :class
              super("//div[contains(@#{how.to_s},'#{what}')]")
            when :locator
              super(what)
            else
              raise "Don't know how to init DwrContainer by '#{how}' with '#{what}'"
          end
        else
          super(how)
        end
        @fieldname ||= {}
      end

      # Tries to find locator of input field (checkbox, radiobox, combobox, checkbox, etc.) by specified key.
      # @param [String] key label of the required input field.
      # @return [String] XPath locator of required input field.
      def get_field_locator(key)
        if @fieldname[key]
          "#{@locator}//*[contains(@#{@fieldname[key][0]},'#{@fieldname[key][1]}')]#{@fieldname[key][2].nil? ? '/input' : @fieldname[key][2]}"
        else
          "#{@locator}//*[//label[text()='#{key}']/@for and contains(@id,//label[text()='#{key}']/@for)]"
        end
      end

      # @deprecated (see ExtElement)
      def get_ext_field_locator(key)
        "#{@locator}//label[text()='#{key}']/following::input[1]"
      end

      # Tries to find locator of input field (checkbox, radiobox, combobox, checkbox, etc.) by specified key.
      # @note Use only if {#get_field_locator} fails to find required field.
      # @param (see #get_field_locator)
      # @param [String] the value should be 'left' or 'right' to figure out the alignment of this field, default is left.
      # @return (see #get_field_locator)
      def get_uni_field_locator(key, align = 'left')
        element = Element.new("(#{@locator}//*[text()='#{key}']//input[1] | #{@locator}//*[text()='#{key}']//textarea[1])")
        if element.is_present?
          element.get_locator
        end

        element = Element.new("(#{@locator}//*[contains(text(), '#{key}')]//input[1] | #{@locator}//*[contains(text(), '#{key}')]//textarea[1])")
        if element.is_present?
          element.get_locator
        else
          if align == 'left'
            element = Element.new("(#{@locator}//*[text()='#{key}']/following::input[1] | #{@locator}//*[text()='#{key}']/following::textarea[1])")
            if element.is_present?
              element.get_locator
            else
              Element.new("(#{@locator}//*[contains(text(), '#{key}')]/following::input[1] | #{@locator}//*[contains(text(), '#{key}')]/following::textarea[1])").get_locator
            end
          else
            element = Element.new("(#{@locator}//*[text()='#{key}']/preceding::input[1] | #{@locator}//*[text()='#{key}']/preceding::textarea[1])")
            if element.is_present?
              element.get_locator
            else
              Element.new("(#{@locator}//*[contains(text(), '#{key}')]/preceding::input[1] | #{@locator}//*[contains(text(), '#{key}')]/preceding::textarea[1])").get_locator
            end
          end
        end
      end

      # Set value of the input field with specified label.
      # @param [String] key label of the required input field.
      # @param [String] value to set into required input field.
      # @param [String] the value should be 'left' or 'right' to figure out the alignment of this field, default is left.
      # @raise [RuntimeError] when required input field is not found.
      def set_value(key, value, align = 'left')
        unless $browser.is_element_present(field_locator = get_field_locator(key))
          field_locator = get_uni_field_locator(key, align)
        end
        $browser.wait_for_element_present(field_locator, 3, false) ? nil : raise("Field with key '#{key}' isn't found")
        tag_name = $browser.find_element(:xpath, field_locator).tag_name

        if tag_name == "textarea"
          element = Element.new(field_locator)
          element.clear_value
          element.set_value(value)
        else
          field_type = $browser.is_element_present("#{field_locator}[@type]") ? $browser.find_element(:xpath, field_locator).attribute("type") : "select"
          field_class = $browser.is_element_present("#{field_locator}[@class]") ? $browser.find_element(:xpath, field_locator).attribute("class") : nil

          case field_type
            when "text", "password"
              case field_class
                when /x-combo/ #ext-combobox
                  ExtComboBox.new(:locator, field_locator).select(value)
                when nil, "dim", /dateTimeField/ #textbox
                  element = Element.new(field_locator)
                  element.clear_value
                  element.set_value(value)
                else
                  raise "Unknown text field with class '#{field_class}'"
              end
            when "radio" #radiobox
              radio_name = $browser.find_element(:xpath, field_locator).attribute("name")
              field_locator = "//input[@name='#{radio_name}']"
              value = case value.downcase
                        when "on", "off", ""
                          key
                        else
                          value
                      end
              field_locator += "[contains(following-sibling::*[text()][1],'#{value}')]"
              RadioBox.new(field_locator).click
            when "select" #standard html select
              $browser.select(field_locator, "label=#{value}")
            when "checkbox"
              if ($browser.get_xpath_count(field_locator).to_i > 1)
                value.split(',').each do |param|
                  CheckBox.new(:locator, "#{field_locator}[@value='#{param}']").toggle #checkbox groups
                end
              else
                CheckBox.new(:locator, "#{field_locator}").toggle(value)
              end
            else
              raise "Unknown field with type '#{field_type}'"
          end
        end
      end

      # Tries to get element/container from inside this.
      # @param [String, Class] type of required element/container.
      # @param [String] title of required element/container.
      # @return [Object] instance of required element/container object.
      # @raise [RuntimeError] when required type is unknown.
      def get_element(type, title = nil, index = 1)
        aliases = {
            "screen" => Screen,
            "dialog" => Dialog,
            "popup" => Popup,
            "panel" => Panel,
            "popupmenu" => PopupMenu,
            #"textbox"        => TextBox,
            #"tile" => TileBox,
            #"chart" => Chart,
            "tree" => Tree,
            "tree table" => TreeWcfTable,
            "grid" => GridWcfTable,
            #"text" => Text,
            "tab" => Tab,
            "link" => Link,
            "cylinder" => Cylinder,
            "border" => BorderBox,
            #"icon" => Icon,
            #"inventory" => Inventory,
            "search" => SearchField,
            "button" => Button,
            #"select" => Select,
            #"dropdown" => Select,
            #"headertext" => HeaderText,
            "topology" => ColumnTopology,
            "topology node" => ColumnTopologyNode,
            "topology group" => ColumnTopologyGroupNode
            # table is just for testing scope function, will be removed later
            #"table" => Table
        }
        container_class = aliases[type.to_s.downcase].nil? ? type : aliases[type.to_s.downcase]
        begin
          container_class.new(title, @locator, index)
        rescue NameError
          raise "Unknown element with type '#{type}'"
        end
      end
    end
  end
end
