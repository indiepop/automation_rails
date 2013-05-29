module WCF
  module Components

    class AlarmSummaryView < DwrContainer
      def initialize
        super("//table[contains(@class, 'grid wcfTable')]/thead/tr/th[@header-id='alarms']/../../..")
      end

      def contains?(header, value)
        value == $browser.find_element("#{@locator}/tbody/tr/td/div[@column-id='#{header.downcase}']/a/span").text
      end
    end
  end
end