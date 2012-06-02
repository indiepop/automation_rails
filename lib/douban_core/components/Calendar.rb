module WCF
  module Components
    # Represents Calendar in the application by label name.
    class Calendar < DwrElement

      # Uses {DwrElement#initialize} with date time field locator generation options.
      # @param [String] label before calendar field
      # @param [String] under_locator parent locator.
      # @param [Integer] index of calendar
      def initialize title, under_locator = nil, index = 1
        super("#{under_locator}//descendant-or-self::input[@class='dateTimeField' and parent::div[preceding-sibling::div[text()='#{title}']]][#{index}]")

        # calendar panel xpath
        @@date_panel_xpath = "#{under_locator}//div[@class='popup' and contains(@style,'visibility: visible') and .//table[@class='calendarHeader'] and .//table[@class='calendar']]"
      end

      # Hash table for month
      @@month_array = {"January" => 1,
                       "February" => 2,
                       "March" => 3,
                       "April" => 4,
                       "May" => 5,
                       "June" => 6,
                       "July" => 7,
                       "August" => 8,
                       "September" => 9,
                       "October" => 10,
                       "November" => 11,
                       "December" => 12}

      # Get calendar panel path
      def date_panel_xpath
        @@date_panel_xpath
      end

      # Get current date in calendar panel
      def get_year_month
        date = Object.new("#{date_panel_xpath}//table[@class='calendarHeader']/tbody/tr/td[2]").text
        @@year = date.match(/\d+/).to_s.strip.to_i
        @@month = @@month_array[date.match(/\w+/).to_s.strip].to_i
      end

      # Select year
      def select_year year
        year = year.to_i
        get_year_month
        until @@year == year
          previous_arrows = Object.new("#{date_panel_xpath}//table[@class='calendarHeader']//img[@title='Previous Year']")
          next_arrows = Object.new("#{date_panel_xpath}//table[@class='calendarHeader']//img[@title='Next Year']")
          get_year_month
          if @@year > year
            previous_arrows.click
          elsif @@year < year
            next_arrows.click
          end
        end
      end

      # Select month
      def select_month month
        month = month.to_i
        if month < 1 or month > 12
          raise "Month #{month} is not legal"
        end
        get_year_month
        until @@month == month
          previous_arrows = Object.new("#{date_panel_xpath}//table[@class='calendarHeader']//img[@title='Previous Month']")
          next_arrows = Object.new("#{date_panel_xpath}//table[@class='calendarHeader']//img[@title='Next Month']")
          get_year_month
          if @@month > month
            previous_arrows.click
          elsif @@month < month
            next_arrows.click
          end
        end
      end

      # Select day
      def select_day day
        day_object = Object.new("#{date_panel_xpath}//table[@class='calendar']//td[text()='#{day}' and @class!='otherMonth']")
        if day_object.is_present?
          day_object.click
        else
          raise "Day #{day.to_s} is not legal in month #{@@month}."
        end
      end
    end
  end
end