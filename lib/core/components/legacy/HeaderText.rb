module WCF
  module Components

    class HeaderText < DwrElement

      def initialize(text, under_locator = nil)
          super("#{under_locator}//div[contains(@class,'border')]/div[2]/span[text()='#{text}']")
      end
    end
  end
end
