module WCF
  module Components

    # Represents calendar from Wcf component in the application.
    class CalendarForm < DwrContainer
      @@button_locator = "//div[@id='timeRangeMenu']/span[@class='button']"

      # Uses {DwrContainer#initialize} with calendar form locator generation options.
      def initialize
        super("//div[@id='pageHeader']/div[contains(@class,'panel') and contains(@style,'visibility: visible')]")
        @fieldname = {
            'From'               => ['name', 'fromDate'],
            'To'                 => ['name', 'toDate'],
            'Earliest available' => ['name', 'startsWithEarliest', ''],
            'Current time'       => ['name', 'endsWithNow', ''],
            'Granularity'        => ['name', 'granularity', '']
        }
      end

      # Show calendar form if it is hidden.
      def show
        loop do
          if is_present?
            break
          else
            $browser.click_at(@@button_locator,"1,1")
            sleep(1)
          end
        end
      end

      # Hide calendar form if it is shown.
      def hide
        loop do
          if is_present?
            if $browser.is_element_present("#{@locator}[contains(@class,'docked')]")
              $browser.click_at(@@button_locator,"1,1")
            else
              $browser.click_at("//html","1,1")
            end
            sleep(1)
          else
            break
          end
        end
      end

      # Dock calendar form if it is not docked yet.
      def dock
        unless $browser.is_element_present("#{@locator}[contains(@class,'docked')]")
          show
          $browser.click_at(@@button_locator,"1,1")
        end
      end
    end
  end
end
