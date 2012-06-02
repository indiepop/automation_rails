module WCF
  module Components

    # Represents popup framed boxes container in the application.
    class PrmPopupContainer < DwrContainer
      # Uses {DwrContainer#initialize} with framed box locator generation options.
      # @param [String] under_locator locator of the parent container.
      def initialize(under_locator = nil)
        super("#{under_locator}//div[@id='prmPopupContainer']")
      end

      # Get special framed box in prmPopupContainer
      # @param [String] title of the framedbox.
      # @param [String] framedbox step in prmPopupContainer.
      # @return [FramedBox] special framed box.
      def get_framed_box(title = nil, step = "1")
        begin
          Dialog.new(title, @locator, step)
        rescue RuntimeError
          raise "FramedBox with '#{title}' title and step #{step} isn't found."
        end
      end
    end
  end
end
