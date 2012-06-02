module WCF
  module Components

    # Represents grids from Wcf component in the application usually by the title.
    class GridWcfTable < DwrContainer
      # Uses {DwrContainer#initialize} with grid locator generation options.
      # @param [String] title of the grid.
      # @param [String] under_locator locator of the parent container.
      def initialize(title = nil, under_locator = nil, index = 1)
        index = index.nil? ? "1" : index
        if title == "[unnamed]" or title.to_s == ''
          grid_locator = "#{under_locator}/descendant::table[.//thead//div[@column-id] and contains(@class, 'grid')][#{index}]"
          if Object.new(grid_locator).is_present?
            super(grid_locator)
          else
            # if grid do not contains grid title, use this locator instead
            super("#{under_locator}/descendant::table[contains(@class, 'grid')][#{index}]")
          end
        else
          #super("#{under_locator}//span[text()='#{title}']/following::table[contains(@class,'grid wcfTable')][#{index}]")
          super("#{under_locator}//span[text()=#{$browser.generate_concat_for_xpath_text title}]/following::table[.//thead//div[@column-id] and contains(@class, 'grid')][#{index}]")
        end
      end

      # Verify that row is inside grid or not.
      # @note Performs {#wait} before acting.
      # @param [Hash{String => String}] row column header => value.
      # @return [Boolean] true if row found, false otherwise.
      def include?(row, second = 5)
        wait
        get_row(row, second).nil? ? false : true
      end

      # Generate locator for the row with specified conditions (values).
      # @param (see #include?)
      # @return [GridWcfTableRow] object with generated locator.
      def get_row(values, second = 5)
        condition = ""
        values.each do |header, value|
          unless condition.empty?
            condition += " and "
          end
          lastpart = ""
          if header != "[unnamed]" and header != ""
            lastpart = "/@column-id=preceding::thead[1]/tr/th/div[.//text()=#{$browser.generate_concat_for_xpath_text header} " +
                       "or normalize-space(.//text())=#{$browser.generate_concat_for_xpath_text header}]/@column-id"
          end
          if value =~ /^\[img\](.*)$/ # For the image processing
            condition += "td/div[.//img[contains(@src,#{$browser.generate_concat_for_xpath_text $1})]]#{lastpart}"
          elsif value == "[spark]" # For the spark line processing
            condition += "td/div[.//canvas]#{lastpart}"
          elsif value =~ /^\[fuzzy\](.*)$/
            condition += "td/div[.//*[contains(text(),#{$browser.generate_concat_for_xpath_text $1})]]#{lastpart}"
          elsif value =~ /^\[fuzzy\](.*)$/
            condition += "td/div[.//*[contains(text(),#{$browser.generate_concat_for_xpath_text $1})]]#{lastpart}"
          elsif ['[selected]', '[unselected]'].include?(value)
            condition += "contains(@class,'SelectedRow')"
          else
            condition += "td/div[.//text()=#{$browser.generate_concat_for_xpath_text value}]#{lastpart}"
          end
        end

        while true
          row = GridWcfTableRow.new("#{@locator}/tbody/tr[#{condition}]")

          path = "#{@locator}/tbody/tr[#{condition}]"
          puts path

          $browser.wait_for_body_text

          if row.wait(second, false)
            return row
          else
            if is_scrollbar_reach_bottom?
              return nil
            else
              drop_vscrollbar
            end
          end
        end
      end

      def get_row_index(index)
        element = GridWcfTableRow.new("#{@locator}/tbody/tr[#{index}]")
        element.is_present? ? element : nil
      end

      # Count rows inside the grid (current page, if multiple).
      # @note (see #include?)
      # @return [Number] rows count.
      def rows_count
        wait
        $browser.find_elements(:xpath, "#{@locator}/tbody/tr").size()
      end

      # Checks the Check All checkbox in the grid.
      # @note (see #include?)
      def check_all
        wait
        $browser.find_element(:xpath, "#{@locator}/thead/tr/th/div/input[contains(@name, 'selectAllControl')]").click
      end

      # Verify that grid have specified column and the index of that column.
      # @param [String] title of the column.
      # @param [Number] index of the column starting from 1.
      # @return [Boolean] true if column found, false otherwise.
      def include_column?(title, index = nil)
        wait
        if index.nil?
          Element.new("#{@locator}/thead/tr/th[.//text()=#{$browser.generate_concat_for_xpath_text title}]").is_present?
        else
          Element.new("#{@locator}/thead/tr/th[#{index}][.//text()=#{$browser.generate_concat_for_xpath_text title}]").is_present?
        end
      end

      # click customize object.
      def click_customize
        wait
        element = Element.new("#{@locator}//img[contains(@id,'TableCustomizer')]")
        if element.is_present?
          element.click_at("1,1")
        else
          element = Element.new("#{@locator}/ancestor::div[div[@class='toolbar']]/div[@class='toolbar']//img[contains(@id,'TableCustomizer')]")
          if element.is_present?
            element.click_at("1,1")
          else
            element = Element.new("#{@locator}/ancestor::div[span[@class='wcfTableCustomizerFiller grid' or @wcf:classname='wcfTableCustomizerFiller grid']]//img[contains(@id,'TableCustomizer')]")
            if element.is_present?
              element.click_at("1,1")
            else
              raise RuntimeError, "This customize isn't found."
            end
          end
        end
      end

      # Click toolbar button on the top of grid table.
      # @param [String] the title of the toolbar button.
      def click_toolbar_button name
        wait
        Button.new(name, "#{@locator}/ancestor::div[div[@class='toolbar']]/div[@class='toolbar']").click
      end

      # Click vscrollbar object to drop page down.
      def drop_vscrollbar
        element = Element.new("(#{@locator}/ancestor::div | #{@locator}/following::div)[div[@class='vscrollbar']]/div[@class='vscrollbar']/div[contains(@class,'down')]")
        element.click
      end

      # Verify scroll bar reach bottom or not
      # @return [Boolean] true or false
      def is_scrollbar_reach_bottom?
        begin
          thumb = Element.new("(#{@locator}/ancestor::div | #{@locator}/following::div)[div[@class='vscrollbar']]/div[@class='vscrollbar']/div[contains(@class,'thumb')]")
          if thumb.is_present?
            $browser.execute_script("var evt = document.createEvent('MouseEvents');" +
                                        "evt.initMouseEvent('mouseover',true, true, window, 0, 0, 0, 0, 0, false, false, false, false, 0,null);" +
                                        "arguments[0].dispatchEvent(evt);", thumb.get_element)

            tracker_tip = Element.new("//div[@id='trackerDwell' and @class='tooltip']")
            tracker_text = tracker_tip.text.strip

            if tracker_text =~ /(\d+)-(\d+)\/(\d+)/
              return $2 == $3
            else
              raise "Tool tip not match /(\\d+)-(\\d+)\\/(\\d+)/"
            end
          else
            return true
          end
        rescue Exception => e
          raise "Scroll bar reach bottom has exception: #{e}"
        end
      end

      # Search specified rows by value.
      # @param [String] value.
      def set_search_field_value value
        search_field = SearchField.new("", "#{@locator}/ancestor::div[div[@class='toolbar']]/div[@class='toolbar']")
        search_field.clear_value
        search_field.set_value(value)
      end

      # Get specified element which text is specified.
      # @param [String] element's text'.
      # @return [Element]
      def get_value(key)
        Element.new("#{@locator}//*[text()=#{$browser.generate_concat_for_xpath_text key}]")
      end

    end
  end
end
