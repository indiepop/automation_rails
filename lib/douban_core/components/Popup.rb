module WCF
  module Components

    # Represents popup in the application by the title.
    class Popup < DwrContainer
      # Uses {DwrContainer#initialize} with popup locator generation options.
      # @param [String] title of the popup.
      def initialize(title = nil, under_locator = nil, index = 1)
        if title == "[unnamed]" or title.to_s == '' or title.nil?
          super("#{under_locator}//*[(@id='popup' or @class='popup')][#{index}]")
        else
          title = generate_concat_for_xpath_text(title)
          super("#{under_locator}//*[(@id='popup' or @class='popup') and contains(.,#{title})][#{index}]")
        end
      end

      # Get name of Popup on the screen.
      # @return [String, nil] name of Popup on the screen, or nil of there is no popup.
      def self.get_popup_name
        if Popup.new.is_present?
          Element.new("//*[@id='popup' or @class='popup']").get_value
        end
      end

      #select the option of the popup menu and click
      # @param [String] item of the popup menu
      # @see Element#click
      def select(option)
        locator = "#{@locator}//li/a[text()='#{option}'] | #{@locator}//span[text()='#{option}']"
        DwrElement.new(locator).click
      end
    end
  end
end