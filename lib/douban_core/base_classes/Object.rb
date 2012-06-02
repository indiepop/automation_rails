module WCF
  module Components

    # Base class for the element and container
    # use this class for initializing object and the common methods
    class Object

      # Set the instance variable @locator and adds Anti-Hidden-XPath suffix to it.
      # @param [String] locator to the object in XPath, this XPath should be the outermost layer
      def initialize(locator)
        anti_hidden_xpath = "[count(ancestor-or-self::*[not(contains(@style,'display: none'))" +
            " and not(contains(@style,'visibility: hidden'))])=count(ancestor-or-self::*)]" #Prevent hidden elements
        @locator = locator.gsub(anti_hidden_xpath, '') + anti_hidden_xpath
      end

      # Verifies if the object have *visible* in *@style* or not.
      # @return [Boolean] container have *visible* or not.
      # @see http://selenium.rubyforge.org/rdoc/classes/Selenium/SeleniumDriver.html#M000203 SeleniumDriver.is_element_present
      def is_visible?
        $browser.is_element_present("#{@locator}[contains(@style,'visible')]")
      end

      # Verifies if the element present or not on page.
      # @return [Boolean] element present or not.
      # @see http://selenium.googlecode.com/svn/trunk/docs/api/rb/Selenium/WebDriver/SearchContext.html#find_element-instance_method
      def is_present?
        $browser.is_element_present(@locator)
      end

      # Wait for element to become present on page.
      # @param [Number] seconds seconds to wait, or nil for default timeout (specified in {file:configuration.yaml}).
      # @param [Boolean] throw exception or not on timeout.
      # @return [true] if element become present.
      # @raise [RuntimeError] after timeout.
      # @see SeleniumUtils#wait_for_element_present
      def wait(seconds = nil, throw = true)
        $browser.wait_for_element_present(@locator, seconds, throw)
      end

      # Clicks the Object.
      # @note Performs {#wait} before acting.
      # @see http://selenium.rubyforge.org/rdoc/classes/Selenium/SeleniumDriver.html#M000125 SeleniumDriver.click
      def click
        wait
        $browser.find_element(:xpath, @locator).click
      end

      # Get the text content of this element
      # @return [String] text content of element
      # @see http://selenium.googlecode.com/svn/trunk/docs/api/rb/Selenium/WebDriver/Element.html#text-instance_method
      def text
        wait
        $browser.find_element(:xpath, @locator).text
      end

      # Get the element
      # @return [Element] element
      # @see http://selenium.googlecode.com/svn/trunk/docs/api/rb/Selenium/WebDriver/SearchContext.html#find_element-instance_method
      def get_element
        $browser.find_element(:xpath, @locator)
      end

      # Get the locator
      # @return [String] locator
      def get_locator
        @locator
      end

      # Get the value of a the given attribute of the element. Will return the current value, even if this has been
      # modified after the page has been loaded. More exactly, this method will return the value of the given attribute,
      # unless that attribute is not present, in which case the value of the property with the same name is returned.
      # If neither value is set, nil is returned. The “style” attribute is converted as best can be to a text representation
      # with a trailing semi-colon. The following are deemed to be “boolean” attributes, and will return either “true” or “false”:
      def attribute name
        wait
        $browser.find_element(:xpath, @locator).attribute name
      end

      # Method to generate xpath switch between Double Quote and Single Quote
      # @param [String] text of value which contains Quote
      # @return [String] xpath text
      def generate_concat_for_xpath_text(text)
        $browser.generate_concat_for_xpath_text text
      end

    end
  end
end