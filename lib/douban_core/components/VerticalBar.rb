module WCF
  module Components

    # Represents vertical bar in the application usually by the title.
    class VerticalBar < Metric

      def initialize(title, under_locator = nil, index = 1)
        super("//descendant-or-self::div[contains(@class, 'vbargauge') and div[contains(@id, '_label') and span[text()='#{title}']]][#{index}]")
      end

      # Get the severe of the horizontal bar, possible value are: normal, warn, error, fatal.
      # return nil if it's not able to get the value
      # @note Performs {#wait} before acting.
      # @return [String or nil] the severe shown on the horizontal bar.
      def severe
        wait
        icon = Element.new(@locator + "/div/span[contains(@class, 'value')]/img")

        if icon.is_present?
          image_name = icon.attribute("src").split('/').last
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

      # Return the title of the horizontal bar.
      # @note Performs {#wait} before acting.
      # @return [String] the title of the horizontal bar.
      def title
        wait
        Element.new(@locator + "/div/span[contains(@class, 'label')]").get_value
      end

      # Reture the value in percentage of severe.
      # @note Performs {#wait} before acting.
      # @return [Integer] the percentage of severe.
      def value
        wait
        Element.new(@locator + "/div/span[contains(@class, 'value')]").get_value.to_i
      end
    end
  end
end