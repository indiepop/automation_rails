module WCF
  module Components

    # Represents inventory boxes in the application by the title.
    class Inventory < DwrContainer
      @@alarms = {
          "failure"  => "1",
          "fatal"    => "1",
          "critical" => "2",
          "warning"  => "3",
          "normal"   => "4"
      }

      # Uses {DwrContainer#initialize} with inventory box locator generation options.
      # @param [String] title of the inventory box.
      # @param [String] under_locator locator of the parent container.
      def initialize(title, under_locator = nil, index = 1)
          super("#{under_locator}//descendant-or-self::div[div[2][a[text()='#{title}']]][#{index}]")
      end

      # Get the total amount of alarms in the inventory box by retrieving sum number from it.
      # @note Performs {#wait} before acting.
      # @return [String] amount of alarms.
      # @raise [SeleniumError] when amount cannot be retrieved.
      def get_count
        wait
        $browser.get_text("#{@locator}/div[last()]")
      end

      # Get the amount of entities specified by type.
      # @note (see #get_count)
      # @return [String] amount of specified entities.
      # @raise [SeleniumError] when amount cannot be retrieved.
      # @raise [RuntimeError] when unknown entity type required. Possible only: failure, critical, warning, normal.
      def get_current(entity)
        wait
        @@alarms[entity.downcase].nil? ? raise("Unknown alarm '#{entity}'. Possible alarms is: failure (fatal), critical, warning, normal.") : nil
        $browser.get_text("#{@locator}/div[count(div)=4]/div[#{@@alarms[entity.downcase]}]/div[last()]//span")
      end

      # Clicks on the inventory title.
      # @note (see #get_count)
      def click
        Element.new("#{@locator}/div[2]/a").click_at
      end

      # Get path to an image file in the inventory.
      # @note (see #get_count)
      # @return [String] path to image.
      def get_image_name
        wait
        $browser.get_attribute("#{@locator}/div[last()-1]//img/@src")
      end
    end
  end
end
