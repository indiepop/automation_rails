module WCF
  module Components

    # Represents framed boxes in the application by the title.
    class ExtDialog < DwrContainer

      # Uses {DwrContainer#initialize} with framed box locator generation options.
      # @param [String] title of the extdialog.
      # @param [String] under_locator locator of the parent container.
      def initialize(title = nil, under_locator = nil, index = 1)
        condition ="div/div/span/b[.//text()=#{generate_concat_for_xpath_text title}]"
        super("#{under_locator}//descendant-or-self::div[@id='registrypanel' or @id='instancePanel' and #{condition}][#{index}]")
      end

    end
  end
end
