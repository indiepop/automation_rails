module WCF
  module Components

    # Represents flow gauge in the application usually by the title.
    class FlowGauge < DwrElement

      # Uses {DwrElement#initialize} with flow gauges locator generation options.
      # @param [String] title of the flow gauges.
      # @param [String] under_locator locator of the parent container.
      def initialize(title = nil, under_locator = nil, index = 1)
        if title == "[unnamed]" or title.to_s == ''
          super("#{under_locator}//div[contains(@class, 'componentBody') and img[contains(@style,'flow-gauge')]][#{index}]")
        else
          super("#{under_locator}//div[contains(@class, 'componentBody') and img[contains(@style,'flow-gauge')] and div[1][contains(text(), '#{title}')]][#{index}]")
        end
      end

      def title
        
      end

      # @return [String] the severe of the cylinder
      # will return blank nil if the severe is unknown
      # possible value are: normal, warning, critical, fatal, not available, etc
      def severe
        wait
        metric = Element.new(@locator + "/img[contains(@style,'flow-gauge')]")
        if metric.is_present?
          metric.attribute("alt").downcase
        else
          raise "The cylinder can not be found."
        end
      end

      # @return [String] the value of the cylinder
      # will return value under the cylinder, and return nil if no value present
      def value
        wait
        value_label = Element.new(@locator + "/div[2]")
        value_label.is_present? ? value_label.get_value : nil
      end
    end
  end
end