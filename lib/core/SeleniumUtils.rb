require 'rubygems'
require 'selenium/webdriver'


module WCF
  module Utils

    # Additional tools that can be useful dealing with Selenium::SeleniumDriver.
    # @author Oleksii Matiiasevych, lastperson@gmail.com
    # example: SeleniumUtils.for :ff,opts={:timeout=>60000}}
    class SeleniumUtils < Selenium::WebDriver::Driver

      def self.for(browser, opts = {})
        @@timeout = opts[:timeout] ? opts.delete(:timeout) : 30000
        super(browser, opts)
      end

      def get_timeout
        @@timeout / 1000
      end

      # Wait until page body text become stable (unchanged more then 1 second).
      # @param [Number] seconds to wait.
      # @return [Boolean] true if page body become stable, false on timeout.
      def wait_for_body_text(seconds=nil)
        seconds ||= @@timeout / 1000
        wait_for_element_not_present("//img[@id='busyIndicator' and contains(@style,'visible')]", seconds)
        seconds.times do
          begin
            text = page_source()
            sleep(1)
            if text == page_source()
              return true
            end
          rescue Selenium::WebDriver::Error::WebDriverError
            sleep(1)
          end
        end
        false
      end

      # Return the text from a specific element.
      # @param [String] locator of the element.
      # @return [String] the text of the element.
      # @raise [Selenium::WebDriver::Error::NoSuchElementError] raise error is element not found.
      def get_text locator
        $browser.find_element(:xpath, locator).text
      end

      # Wait until element XPath become present in page structure.
      # @param [String] locator of the element.
      # @param [Number] seconds to wait.
      # @param [Boolean] throw exception or not on timeout.
      # @return [Boolean] true if element become present, false on timeout.
      # @raise [RuntimeError] after timeout, if throw == false.
      def wait_for_element_present(locator, seconds=nil, throw=true)
        seconds ||= @@timeout / 1000
        result  = false
        seconds.times do
          if is_element_present(locator)
            result = true
            break
          else
            sleep(1)
          end
        end
        result ? true : throw ? raise("Element '#{locator}' not present for #{seconds} seconds timeout") : false
      end

      # Wait until element XPath disappear from page structure.
      # @param [String] locator of the element.
      # @param [Number] seconds to wait.
      # @return [Boolean] true if element become present.
      # @raise [RuntimeError] after timeout.
      def wait_for_element_not_present(locator, seconds=nil, throw=true)
        seconds ||= @@timeout / 1000
        result  = false
        seconds.times do
          if not is_element_present(locator)
            result = true
            break
          else
            sleep(1)
          end
        end
        result ? true : throw ? raise("Element '#{locator}' still present for #{seconds} seconds timeout") : false
      end

      # Overloads Selenium::SeleniumDriver.wait_for_page_to_load to perform wait_for_body_text after it.
      def wait_for_page_to_load(timeout=@@timeout)
        super(timeout)
        wait_for_body_text
      end

      # Check if the specific element exist in page
      # @locator the xpath to the element you are looking for
      def is_element_present(locator)
        if find_element(:xpath, locator)
          return true
        end
      rescue Selenium::WebDriver::Error::NoSuchElementError
        return false
      rescue Selenium::WebDriver::Error::UnexpectedJavascriptError
        return false
      rescue Selenium::WebDriver::Error::WebDriverError
        return false
      end

      # This method is for using get_xpath_count in Selenium 2
      # @locator  the xpath to the element that you want to get the xpath count
      def get_xpath_count(locator)
        elements = $browser.find_elements(:xpath, locator)
        elements.length
      end

      # Method to maximize browser window
      def maximize_window
        #execute_script("window.resizeTo(window.screen.width, window.screen.height - 50); window.moveTo(0, 0);")
      end

      # TODO: Selenium does not support capturing screenshot, so this method will be removed or updated.
      #def capture_screenshot(output_name)
      #  self.capture_entire_page_screenshot(File.expand_path(File.dirname(__FILE__)) + '/../../screenshots/' +
      #                                                "#{output_name.gsub(/[?%*:<>.|\\\/]/, '')}.png")
      #end

      # Method to get container locator by scope
      # @param [String] scope
      # @return container locator
      def get_container_locator_by_scope(scope)
        return nil if scope == nil

        in_arr = scope.split(/(\bin\b|\bon\b)/)
        container = DwrContainer.new("")
        (in_arr.size - 1).downto(0) do |i|
          item = in_arr[i].strip if in_arr[i] != nil
          if item != "in" && item != "on" && item =~ /^(\d+\w+ )?('(.+)' )?(\w+)$/
            index = 1
            index = item.match(/^(\d+)/).to_s.to_i if item =~ /^(\d+)/

            object_name = item.match(/'(.+)'/)
            object_type = item.match(/(\w+)$/)
            object_name = object_name[1].to_s if object_name != nil
            object_type = object_type.to_s if object_type != nil

            begin
              container = container.get_element(object_type, object_name, index)
            rescue Exception => e
              raise "Scope: #{scope} is not correct! #{e}"
            end
          else
            raise "Scope: #{scope} is not correct!" if item != "" && item != "in" && item != "on"
          end
        end
        container.get_locator
      end

      # Method to generate xpath switch between Double Quote and Single Quote
      # @param [String] text of value which contains Quote
      # @return [String] xpath text
      def generate_concat_for_xpath_text(text)
        if text.include?("'") or text.include?('"')
          result_string = "concat("
          item_array = text.split(//)
          end_single = item_array.pop
          item_array.each do |item|
            concat_special_string(item, result_string)
            result_string.concat(",")
          end
          concat_special_string(end_single, result_string)
          result_string.concat(")")
        else
          "concat('#{text}', '')"
        end
      end

      def concat_special_string(item, result_string)
        case item
          when "'"
            result_string.concat("\"'\"")
          when '"'
            result_string.concat("'\"'")
          else
            result_string.concat("'#{item}'")
        end
      end

       # This method is for switching into *iframe*
      # @param, [String or integer] iframe id or name or index number
      def switch_to_iframe(id = nil)
        self.switch_to().default_content()
        self.switch_to().frame(id)
      end

      # This method is for switching out *iframe*
      def switch_to_default
        self.switch_to().default_content()
      end
    end
  end
end