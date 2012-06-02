module WCF
  module Components

    # Represents chart in the application usually by the title.
    class Chart < DwrElement
      # Uses {DwrElement#initialize} with chart locator generation options.
      # @param [String] title of the chart.
      # @param [String] under_locator locator of the parent container.
      def initialize(title = nil, under_locator = nil, index = 1)
        if title == "[unnamed]" or title.to_s == ''
          super("#{under_locator}//descendant-or-self::div[contains(@class,'componentBody') and div[contains(@id,'Chartw')]][#{index}]")
        elsif title =~ /^\[\d+\]$/ # Chart by index
          super("#{under_locator}//descendant-or-self::div[contains(@class,'componentBody') and div[contains(@id,'Chartw')]][#{index}]#{title}")
        else
          super("#{under_locator}//descendant-or-self::span[text()='#{title}']/following::div[contains(@class,'componentBody') and div[contains(@id,'Chartw')]][#{index}]")
        end
      end

      # Clicks on the chart.
      # @note Performs {#wait} before acting.
      def click
        Element.new("#{@locator}//area[contains(@onmouseover,'setupTooltip')]").click_at("5,5")
      end
    end
  end
end
