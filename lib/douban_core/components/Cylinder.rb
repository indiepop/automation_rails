module WCF
  module Components

    # Represents cylinder charts in the application usually by the title.
    class Cylinder < Metric

      # Uses {DwrElement#initialize} with cylinder chart locator generation options.
      # @param [String] title of the cylinder chart.
      # @param [String] under_locator locator of the parent container.
      def initialize(title = nil, under_locator = nil, index = 1)
        if title == "[unnamed]" or title.to_s == ''
          super("#{under_locator}//div[contains(@class, 'componentBody') and img[contains(@id,'cylinder')]][#{index}]")
        else
          super("#{under_locator}//div[contains(@class, 'componentBody') and img[contains(@id,'cylinder')] and div[contains(@id, '_label') and contains(text(), '#{title}')]][#{index}]")
        end
      end

      # Verifies that cylinder have specified parameter.
      # @note Performs {#wait} before acting.
      # @param [String] param to verify.
      # @return [Boolean] true
      def verify_parameter?(param)
        wait
        $browser.is_element_present("#{@locator}/div[contains(.,'#{param}')]")
      end

      # @return [String] the severe of the cylinder
      # will return blank nil if the severe is unknown
      # possible value are: normal, warning, critical, fatal, not available, etc
      def severe
        wait
        cylinder = Element.new(@locator + "/img[contains(@id,'cylinder')]")
        if cylinder.is_present?
          cylinder.attribute("alt").downcase
        else
          raise "The cylinder can not be found."
        end
      end

      # @return [String] the value of the cylinder
      # will return value under the cylinder, and return nil if no value present
      def value
        wait
        value_label = Element.new(@locator + "/div[contains(@id,'_number')]")
        value_label.is_present? ? value_label.get_value : nil
      end
    end
  end
end
