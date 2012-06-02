module WCF
  module Components

    # Represents static grids in the application by the title.
    class Grid < DwrContainer
      # Uses {DwrContainer#initialize} with grid locator generation options.
      # @param [String] title of the grid.
      # @param [String] under_locator locator of the parent container.
      def initialize(under_locator, title = nil)
        unless title.nil?
          super("#{under_locator}//table[.//table//td[@class='componentTitle' and contains(.,'#{title}')]]")
        else
          super("//table[.//table//td[@class='componentTitle' and contains(.,'#{under_locator}')]]")
        end
      end

      # Collect all headers of the grid.
      # @note Performs {#wait} before acting.
      # @return [Hash{String => Number}] column name => column index.
      def get_headers
        wait
        headers         = {}
        headers_locator = "#{@locator}//table[@id='dataHeader']/tbody/tr/th[a]"
        i               = 1
        while begin
          headers[$browser.get_text("#{headers_locator}[#{i}]/a")] = i
        rescue SeleniumCommandError
          false
        end
          i+=1;
        end
        headers
      end

      # Verify that row is inside grid or not.
      # @note (see #get_headers)
      # @param [Hash{String => String}] row column header => value.
      # @return [Boolean] true if row found, false otherwise.
      def include?(row)
        wait
        get_row(row).is_present?
      end

      # Generate locator for the row with specified conditions (values).
      # @param (see #include?)
      # @return [GridRow] object with generated locator.
      def get_row(values)
        headers   = get_headers
        condition = ""
        values.each do |header, value|
          if (not condition.empty?)
            condition += " and "
          end
    #                  Ultimate locator to speedup method in future if necessary:
    #                  "td[position()=count(preceding::th[a[text()='#{header}']]/preceding-sibling::th)+1 and contains(.,'#{value}')]"
          condition += "td[#{headers[header]} and contains(.,'#{value}')]" # contains(.,'#{value}') works like
          # contains(text(),'#{value}') on drugs
        end
        GridRow.new("#{@locator}//tbody[@id='sdgDataView']/tr[#{condition}]")
      end

      # Count rows inside the grid (current page, if multiple).
      # @note (see #get_headers)
      # @return [Number] rows count.
      def rows_count
        wait
        $browser.get_xpath_count("#{@locator}//tbody[@id='sdgDataView']/tr[@class!='trailer']").to_i
      end
    end
  end
end
