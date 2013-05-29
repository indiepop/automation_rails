module WCF
  module Components

    # Represents {GridWcfTable} rows.
    class GridWcfTableRow < DwrElement
      # Checks the checkbox near the row.
      # @note (see #is_expanded?)
      def check
        get_checkbox.check
      end

      def get_checkbox
        CheckBox.new(:locator, "#{@locator}//input[@type='checkbox']")
      end

      # Click cell specified by column title.
      # @param [String] title of the column.
      # @note (see #is_expanded?)
      def click_cell(title)
        wait
        if title != "[unnamed]" and title != ""
          Element.new("#{@locator}/td[div[@column-id=preceding::thead[1]/tr/th/div[.//text()='#{title}']/@column-id]]//*[not(*)][last()]").click
        else
          Element.new("#{@locator}/td//*[not(*)][last()]").click
        end
      end

      # Click cell specified by column number.
      # @param [Integer] the column number, start from 1.
      # @note (see #is_expanded?)
      def click_cell_by_column_index(number)
        wait
        Element.new("#{@locator}/td[@column-index='#{number-1}']//*[not(*)][last()]").click
      end

      def click_radio
        DwrElement.new(:locator, "#{@locator}//input[@type='radio']").click
      end

      def click_icon name
        Icon.new(name, @locator).click
      end

      def get_cell_value_by_title title
        Element.new("#{@locator}/td[div[@column-id=preceding::thead[1]/tr/th/div[.//text()='#{title}']/@column-id]]/div").get_value
      end

    end
  end
end
