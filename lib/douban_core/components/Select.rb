module WCF
  module Components

    # Represents button in the application by the name.
    class Select < DwrElement
      # Uses {DwrElement#initialize} with select locator generation options. If only first argument passed - will recognize it
      # as name of the select. Second argument is a parent locator.
      # @param [String] name of select.
      # @param [String] under_locator parent locator.
      # @param [Integer] index of select
      def initialize(name = nil, under_locator = nil, index = 1)
        if name == "[unnamed]" or name.to_s == ''
          super("#{under_locator}//descendant-or-self::select[#{index}]")
        else
          name = name.sub(/\[(disabled|enabled)\]/, "").strip
          additional_conditions = case $1
                                    when "enabled"
                                      "[not(@disabled)]"
                                    when "disabled"
                                      "[@disabled]"
                                    else
                                      ""
                                  end
          object = Object.new("#{under_locator}//descendant-or-self::select[ancestor::*[normalize-space(text())='#{name}'] or preceding::*[text()][1][normalize-space(text())='#{name}']]#{additional_conditions}")
          if object.is_present?
            super("#{under_locator}//descendant-or-self::select[ancestor::*[normalize-space(text())='#{name}'] or preceding::*[text()][1][normalize-space(text())='#{name}']]#{additional_conditions}")
          else
            super("#{under_locator}//descendant-or-self::select[ancestor::*[contains(normalize-space(text()),'#{name}')] or preceding::*[text()][1][contains(normalize-space(text()),'#{name}')]]#{additional_conditions}")
          end

        end
      end

      def set_value(value)
        $browser.wait_for_body_text
        Element.new("#{@locator}/option[text()='#{value}'] | #{@locator}/optgroup/option[text()='#{value}']").wait

        options = $browser.find_element(:xpath, @locator)
        option = options.find_elements(:tag_name, "option").find do |item|
          item.text == value
        end
        raise "could not find the option: #{value}" if option.nil?

        option.click
      end

      # verify if the combobox contains specific value
      # @param [String] option value
      # @return [Boolean] true or false
      def contain_value?(value)
        $browser.wait_for_body_text
        option = Element.new("#{@locator}/option[text()='#{value}']")
        option.is_present?
      end
    end
  end
end
