module WCF
  module Components
    # Represents popup menu in the application by the class
    class PopupMenu < DwrElement
      # Uses {DwrElement#initialize} with tab locator generation options.
      # @param [String] name popup menu name.
      def initialize(name, under_locator = nil, index = 1 )
        super("#{under_locator}//descendant-or-self::ul[contains(@class,'popupMenu')][#{index}]")
      end

      #select the option of the popup menu and click
      # @param [String] item of the popup menu
      # @see Element#click
      def select(option)
        locator = "#{@locator}//li[text()='#{option}']"
        DwrElement.new(locator).click
      end
    end
  end
end