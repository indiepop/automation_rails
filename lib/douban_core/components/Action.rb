module WCF
  module Components
    class Action < DwrElement
      def initialize title, under_locator = nil, index = 1
        super("#{under_locator}//descendant-or-self::div[@class='optionStyle' and .//label[text()='#{title}']][#{index}] | //descendant-or-self::span[contains(@id,'Action') and .//span[text()='#{title}']][#{index}]")
      end
    end
  end
end