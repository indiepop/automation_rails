module WCF
  module Components

    # Represents radiobox in the application.
    class RadioBox < DwrElement
      # Verify whether radiobox checked or not.
      # @note Performs {#wait} before acting.
      # @return [Boolean] true if checked, false if not.
      def get_value
        wait
        $browser.is_checked(@locator)
      end
    end
  end
end
