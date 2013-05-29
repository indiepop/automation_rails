module WCF
  module Components
    # Represents inline text editor in the application.
    class InlineTextEditor < DwrElement
      def initialize(under_locator = nil)
        super("#{under_locator}//div[contains(@class, 'inlineTextEditor')]/input")
      end
    end
  end
end
