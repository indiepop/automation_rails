module WCF
  module Components

    # Represents {TreeWcfTable} elements.
    class TreeWcfTableElement < DwrElement
      # Uses {DwrElement#initialize} with {TreeWcfTable} element locator generation options.
      # @param [String] tree_locator locator of the parent {TreeWcfTable}.
      # @param [String, Array<String>] mixpath path to the element. String with '->' separators between elements or Array of
      #  elements.
      # @example mixpath argument:
      #   "Tree head -> tree second level element->tree third level element"
      #   ["Tree head", "tree second level element", "tree third level element"]
      def initialize(tree_locator, mixpath, second_column = nil)
        path = mixpath.is_a?(String) ? split_path(mixpath) : Array.new(mixpath)
        locator = tree_locator
        path.each_index do |index|
          if path[index].start_with?("[selected]")
            path[index] = path[index][10..-1] # slice [selected] prefix
            selected = " and contains(@class,'selectedRow')"
          else
            selected = ""
          end
          if index == 0
            locator += "/tr[@level='0' and .//*[text()='#{path[index]}']#{selected}]"
          else
            if Object.new(locator + "/following-sibling::tr[@level='#{index}' and .//*[text()='#{path[index]}']#{selected}]").is_present?
              locator += "/following-sibling::tr[@level='#{index}' and .//*[text()='#{path[index]}']#{selected}]"
            else
              locator += "/following-sibling::tr[@level='#{index}' and .//*[contains(.,'#{path[index]}')]#{selected}]"
            end
            #locator += "/following-sibling::tr[@level='#{index}' and contains(., '#{path[index]}')#{selected}][1]"
          end
        end
        if second_column.to_s != ""
          if second_column.downcase =~ /^\[img\](.*)$/ # For the image processing
            locator += "[td[2]//img[contains(@src,'#{$1}')]]"
          else
            raise "Only image processing is possible for second column.\nExample: | Element 1 | [img]fname |"
          end
        end
        super(locator)
      end

      # Splits string by '->' separator and strip every element in result.
      # @param [String] path_string to split.
      # @return [Array<String>] array of stripped elements returned by split.
      # @example
      #  split_path("Tree head -> tree second level element->tree third level element") #=> ["Tree head", "tree second level element", "tree third level element"]
      def split_path(path_string)
        path_string.split('->').map! { |element| element.strip }
      end

      # Verify whether element expanded or collapsed.
      # @return [Boolean] true if expanded, false otherwise.
      # @note Performs {#wait} before acting.
      def is_expanded?
        wait
        not Element.new("#{@locator}//img[@class='toggle' and contains(@src,'expand')]").is_present?
        #not $browser.is_element_present("#{@locator}//img[@class='toggle' and contains(@src,'expand')]")
      end

      # Expand element with {#toggle} if it is collapsed.
      # @return [nil] if no action permitted.
      def expand
        toggle unless is_expanded?
      end

      # Collapse element with {#toggle} if it is expanded.
      # @return [nil] if no action permitted.
      def collapse
        toggle if is_expanded?
      end

      # Clicks on the plus or minus near the element.
      # @note (see #is_expanded?)
      def toggle
        Element.new("#{@locator}//img[@class='toggle']").click_at
      end

      # Get path to an image file second column of row.
      # @note (see #is_expanded?)
      # @return [String] path to image.
      def get_image_name
        wait
        $browser.get_attribute("#{@locator}/td[2]//img/@src")
      end

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
        Element.new("#{@locator}/td/div[@column-id=preceding::thead[1]/tr/th/div[.//text()='#{title}']/@column-id]//*[not(*)][last()]").click
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

    end
  end
end
