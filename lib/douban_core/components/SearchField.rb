module WCF
  module Components

    # Represents search fields in the application.
    class SearchField < DwrElement
      # Uses {DwrElement#initialize} with search field locator generation options.
      # @param [String] name of a search field.
      # @param [String] under_locator locator of the parent container.
      def initialize(name = nil, under_locator = nil, index = 1)
        if name == "[unnamed]" or name.to_s == ''
          super("#{under_locator}//descendant-or-self::input[@name='searchField'][#{index}]")
        else
          super("#{under_locator}//span[text()='#{name}']/following::input[@name='searchField'][#{index}]")
        end
      end

      def set_value(value)
        super(value)

        $browser.wait_for_element_present("#{@locator}/following::td[1]/img[contains(@id,'RunningProcessIndicator') and not(contains(@style,'visibility: hidden'))]", 5, false)
        $browser.wait_for_element_not_present("#{@locator}/following::td[1]/img[contains(@id,'RunningProcessIndicator') and not(contains(@style,'visibility: hidden'))]")
        $browser.wait_for_body_text
      end
    end
  end
end
