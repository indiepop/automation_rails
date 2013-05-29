module WCF
  module Components

    # Represents spinner in the application usually by the title.
    class Spinner < Metric

      # Uses {DwrElement#initialize} with metric indicator locator generation options.
      # @param [String] title of the metric indicator.
      # @param [String] under_locator locator of the parent container.
      def initialize(title = nil, under_locator = nil, index = 1)
        if title == "[unnamed]" or title.to_s == ''
          super("#{under_locator}//descendant-or-self::div[contains(@class, 'componentBody') and div/div[contains(@style,'spinner')]][#{index}]")
        else
          super("#{under_locator}//descendant-or-self::div[contains(@class, 'componentBody') and div/div[contains(@style,'spinner')] and div[1][contains(text(), '#{title}')]][#{index}]")
        end
      end

      def title

      end

      # @return [String] the severe of the cylinder
      # will return blank nil if the severe is unknown
      # possible value are: normal, warning, critical, fatal, not available, etc
      def severe
        wait
        icon = Element.new(@locator + "/div/div[contains(@style,'spinner')]")

        if icon.is_present?
          image_name = icon.attribute("style").split('/').last
        else
          return nil
        end

        result = nil
        @@severe.each do |name, type|
          if Regexp.new(name) =~ image_name
            result = type
            break
          end
        end
        result
      end

      # @return [String] the value of the cylinder
      # will return value under the cylinder, and return nil if no value present
      def value
        wait
        value_label = Element.new(@locator + "/div/span")
        value_label.is_present? ? value_label.get_value : nil
      end
    end
  end
end