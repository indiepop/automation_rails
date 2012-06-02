module WCF
  module Components

    # Represents text elements in the application.
    class Text < DwrElement
      # Uses {DwrElement#initialize} with tree locator generation options.
      # @param [String] text inside required element.
      # @param [String] under_locator locator of the parent container.
      def initialize(text, under_locator = nil)
        super("#{under_locator}//*[contains(.,'#{text}')]")
      end
    end
  end
end