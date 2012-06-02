module WCF
  module Components

    # Represents icons in the application.
    class Icon < DwrElement
      # Uses {DwrElement#initialize} with icon locator generation options.
      # @param [String] name of an icon image.
      # @param [String] under_locator locator of the parent container.
      def initialize(name, under_locator = nil, index = 1)
        #name = name.strip.downcase.gsub(/ /, "_")
        super("#{under_locator}//descendant-or-self::*[img[contains(@src, '#{name}')]][#{index}]/img")
      end

      # Returns the value near the icon.
      # @note Performs {#wait} before acting.
      # @return [String] value near the icon.
      def get_value
        wait
        $browser.find_element(:xpath, "#{@locator}/following::div[1]").click
      end

    end
  end
end
