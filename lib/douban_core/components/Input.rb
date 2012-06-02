module WCF
  module Components

    # Represents text box in the application.
    class Input < DwrElement
      def initialize(name = "", under_locator = nil, index = 1)
        if name == "" || name.nil? || name == "[unnamed]"
          super("#{under_locator}//descendant-or-self::input[@type='text' or @type='password'][#{index}]")
        else
          align = 'left'
          actual_key = name
          if name =~ /^\[right\](?:.*)|(?:.*)\[right\]$/
            actual_key = key.sub('[right]', '')
            align = 'right'
          end

          if Element.new("#{under_locator}//*[contains(text(), '#{actual_key}')]//input[1]").is_present?
            super("#{under_locator}//*[contains(text(), '#{actual_key}')]//input[1]")
          else
            if align == 'left'
              Element.new("#{@locator}//*[contains(text(), '#{actual_key}')]/following::input[1]").get_locator
            else
              Element.new("#{@locator}//*[contains(text(), '#{actual_key}')]/preceding::input[1]").get_locator
            end
          end
        end
      end
    end
  end
end
