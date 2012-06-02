module WCF
  module Components

    # Represents key-value element from table like text information in the application.
    class TabledText < DwrElement
      # Uses {DwrElement#initialize} with key-value text element locator generation options.
      # @param [String] name key of the looking element.
      # @param [String] under_locator parent locator.
      def initialize(name, under_locator=nil)
        @name = name
        additional_conditions = ""
        name = name.sub(/^\[img\]([^ ]*)/, '').strip
        unless $1.nil?
          additional_conditions = "[.//img[contains(@src,'#{$1}')]]"
        end
        text_condition = if name != ""
                    "[text()='#{name.sub(/:$/, '')}' or span[text()='#{name}']]"
                  else
                    ""
                  end
        super("#{under_locator}//div#{text_condition}#{additional_conditions}")
      end

      # Get the value of the element.
      # @note Performs {#wait} before acting.
      # @return [String] value of element.
      def get_value
        wait
        $browser.get_text("#{@locator}/following-sibling::div[1]//*[text()][last()]")
      end

      alias :get_key :get_value

      # Compare actual value of the element with provided one.
      # @note (see #get_value)
      # @param [String] value to compare.
      # @return [Boolean] true if values identical, false otherwise.
      def verify_value?(value)
        begin
          wait
        rescue RuntimeError
          raise "Element '#{@name}' isn't found."
        end
        additional_conditions = ""
        unless value.sub!(/\[img\]([^ ]*)/, '').nil?
          additional_conditions += "[.//img[contains(@src,'#{$1}')]]"
        end
        unless value.sub!(/(\[spark\])/, '').nil?
          additional_conditions += "[.//canvas]"
        end
        text_condition = if (value = value.strip) != ""
                    "[.//text()='#{value}']"
                  else
                    ""
                  end
        $browser.is_element_present("#{@locator}/following-sibling::div[1]#{text_condition}#{additional_conditions}")
      end
    end
  end
end