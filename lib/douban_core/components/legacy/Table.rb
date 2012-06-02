module WCF
  module Components
    # This is for testing scope function
    class Table < DwrContainer
      def initialize(title, under_locator = nil, index = 1)
        super("#{under_locator}//table[thead[tr/td/div[@class='componentTitle']//span[text()='#{title}']]][#{index}]")
      end
    end
  end
end