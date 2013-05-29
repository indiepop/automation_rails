module WCF
  module Components
    class Upload < DwrElement
      def initialize(under_locator = nil)
        super("#{under_locator}//input[@type='file']")
      end
    end
  end
end