module WCF
  module Components

    # Represents {Tree} elements.
    class TreeElement < DwrElement
      # Clicks at the element.
      # @note Performs {#wait} before acting.
      # @see http://selenium.rubyforge.org/rdoc/classes/Selenium/SeleniumDriver.html#M000128 SeleniumDriver.click_at
      def click
        Element.new("#{@locator}/span[@class]").click_at
      end
    end
  end
end
