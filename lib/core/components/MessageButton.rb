module WCF
  module Components

    # Represents message button in the application in the top right
    class MessageButton < DwrContainer

      def initialize
        super("//span[@id='messageButton']")
      end

      # get message number
      def get_number
        Element.new("#{@locator}/span[@class='text']").text
      end
    end
  end
end