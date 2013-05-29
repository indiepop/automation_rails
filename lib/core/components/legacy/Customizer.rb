module WCF
  module Components

    # Represents customizer popup box.
    class Customizer < DwrContainer
      # Uses {DwrContainer#initialize} with customizer popup box locator generation options.
      def initialize
        super("//form[contains(@id,'customizerForm')]")
      end
    end
  end
end
