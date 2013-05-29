require "core/base_classes/Object"

module WCF
  module Components
    # Base class for simple elements on page.
    class Element < Object

      # Clicks the element in specified point.
      # @note Performs {#wait} before acting.
      # @param [String] coords coordinates of target point to click.
      # @see http://selenium.googlecode.com/svn/trunk/docs/api/rb/Selenium/WebDriver/Element.html#click-instance_method
      def click_at(coords = "1,1")
        wait
        $browser.find_element(:xpath, @locator).click
      end

      # Types value in the element.
      # @note (see #click)
      # @note Fires 'keyup' event after acting.
      # @param [String] value to be typed.
      # @see http://selenium.googlecode.com/svn/trunk/docs/api/rb/Selenium/WebDriver/Element.html#send_keys-instance_method
      def set_value(value)
        wait
        $browser.find_element(:xpath, @locator).send_keys(value)
      end

      # Returns the text of the element.
      # @note (see #click)
      # @return [String] element text.
      # @see http://selenium.googlecode.com/svn/trunk/docs/api/rb/Selenium/WebDriver/Element.html#text-instance_method
      def get_value
        wait
        $browser.find_element(:xpath, @locator).text
      end

      def clear_value
        $browser.find_element(:xpath, @locator).clear
      end

      # TODO: check and uncheck method should in the checkable element

      # Checks the element if it is CheckBox or RadioBox.
      # @note (see #click)
      # @see http://selenium.googlecode.com/svn/trunk/docs/api/rb/Selenium/WebDriver/Element.html#click-instance_method
      def check
        wait
        element = $browser.find_element(:xpath, @locator)
        unless element.selected?
          element.click
        end
      end

      # Uncheck the element if it is CheckBox or RadioBox.
      # @note (see #click)
      # @see http://selenium.googlecode.com/svn/trunk/docs/api/rb/Selenium/WebDriver/Element.html#click-instance_method
      # @see http://selenium.googlecode.com/svn/trunk/docs/api/rb/Selenium/WebDriver/Element.html#selected%3F-instance_method
      def uncheck
        wait
        element = $browser.find_element(:xpath, @locator)
        if element.selected?
          element.click
        end
      end
    end
  end
end