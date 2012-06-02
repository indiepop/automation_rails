module WCF
  module Components

    # Represents form tabs in the application.
    class Tab < DwrContainer
      # Uses {DwrElement#initialize} with tab locator generation options.
      # @param [String] name tab name.
      def initialize(name, under_locator = nil, index = 1)
        # TODO: don't know if this will affect the code
        #super("#{under_locator}//div[contains(@class, 'tab')]/div[@class='tabContent' and text()='#{name}'] | #{under_locator}//div[contains(@class, 'tab')]/a[@href='#' and text()='#{name}']")
        super("//div[contains(@class, 'tab')]/descendant-or-self::*[(@href='#' or @class='tabContent') and text()='#{name}'][#{index}]")
      end

      def click
        super
        $browser.wait_for_body_text
      end

      # to check if this tab is active currently
      def active?

      end

      # active this tab
      def active
        click
      end

      # get the container of the current tab
      def get_container
        #locators = @locator.split(' | ').collect do |locator|
        #  locator + "/ancestor::div[@class='tabPanel']/following-sibling::div[@class='tabPanelContainer']/div/div"
        #end

        active
        DwrContainer.new(:locator, locators.join(' | '))
      end
    end
  end
end

