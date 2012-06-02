module WCF
  module Components

    # Represents tile boxes from Wcf component in the application by the title.
    class TileBox < DwrContainer

      @@alarms = {
          "failure"  => "1",
          "critical" => "2",
          "warning"  => "3",
          "normal"   => "4"
      }

      # Uses {DwrContainer#initialize} with tile box locator generation options.
      # @param [String] title of the tile box.
      # @param [String] under_locator locator of the parent container.
      def initialize(title, under_locator = nil, index = 1)
        super("#{under_locator}//descendant-or-self::span[@class='tileBox' and span[@class='tileName' and text()='#{title}']][#{index}]")
      end

      # Get the total amount of alarms in the tile box by retrieving sum number from it.
      # @note Performs {#wait} before acting.
      # @return [String] amount of alarms.
      # @raise [SeleniumError] when amount cannot be retrieved.
      def get_count
        wait
        $browser.find_element(:xpath, "#{@locator}/span[@class='tileCount']").text
      end

      # Get the amount of alarms specified by type.
      # @note (see #get_count)
      # @return [String] amount of specified alarms.
      # @raise [SeleniumError] when amount cannot be retrieved.
      # @raise [RuntimeError] when unknown alarm type required. Possible only: failure, critical, warning, normal.
      def get_current(alarm)
        find_alarm_box(alarm).text
      end

      # Click the alarm in tile box by type.
      # @param [String] alarm type. Possible only: failure, critical, warning, normal.
      # @raise [NoSuchElementError] when alarm cannot be retrieved.
      # @raise [RuntimeError] when unknown alarm type required. Possible only: failure, critical, warning, normal.
      def click_alarm(alarm)
        find_alarm_box(alarm).click
      end

    private

      # Find the specific alarm box in tile
      def find_alarm_box(alarm)
        wait
        unless @@alarms[alarm.downcase].nil?
          $browser.find_element(:xpath, "#{@locator}/span[contains(@class,'tileSeverity')][#{@@alarms[alarm.downcase]}]")
        else
          raise("Unknown alarm '#{alarm}'. Possible alarms is: failure, critical, warning, normal.")
        end
      end
    end
  end
end
