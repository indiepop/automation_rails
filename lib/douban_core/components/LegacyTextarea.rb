module WCF
  module Components
    class LegacyTextarea < Element
      def initialize title
        super("//div[@class='x-panel' and //span[@class='x-panel-header-text' and text()='#{title}']]")
      end

      def type_value content
        textarea = Element.new("#{@locator}//textarea")
        textarea.clear_value()
        textarea.set_value(content)
      end
    end
  end
end