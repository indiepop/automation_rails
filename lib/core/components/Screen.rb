module WCF
  module Components

    # Represents main screens in the application usually by the header.
    class Screen < DwrContainer

      # Uses {DwrContainer#initialize} with screen locator generation options.
      # @param [String] header of the screen.
      def initialize(header = "", under_locator = nil, index = 1)
        super("#{under_locator}//div[@id='pageContents' and //*[@id='pageHeader']//*[@class='history']//span[contains(.,'#{header}')]][#{index}]")
      end

      # Tries to retrieve header of the current screen.
      # @return [String] screen header.
      # @raise [SeleniumError] when header cannot be retrieved.
      def self.get_header
        $browser.wait_for_body_text
        $browser.find_element(:xpath, "//*[@id='pageHeader']//*[@class='history']//span[text()]").text
      end

      # Verifies that header of the current screen is the same as given by argument.
      # @param [String] screen expected header.
      # @return [Boolean] true if header is the same as given, false otherwise.
      def self.verify_header(screen)
        $browser.is_element_present("//*[@id='pageHeader']//*[@class='history']//span[contains(.,'#{screen}')]")
      end

      # Tries to retrieve big title of the current screen.
      # @return [String] screen big title.
      # @raise [SeleniumError] when title cannot be retrieved.
      # @note Performs {#wait} before acting.
      def get_title
        wait
        $browser.find_element(:xpath, "#{@locator}//div[contains(@class,'pageTitle')]").text
      end
    end
  end
end
