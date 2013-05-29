module WCF
  module Components

    # Represents tree in the application usually by the title.
    class Tree < DwrContainer
      # Uses {DwrContainer#initialize} with tree locator generation options.
      # @param [String] title of the tree. Very first text (label, title) above the tree.
      # @param [String] under_locator locator of the parent container.
      def initialize(title = nil, under_locator = nil, index = 1)
        if title == "[unnamed]" or title.to_s == ''
          super("#{under_locator}//div[@class='tree'][#{index}]")
        else
          super("#{under_locator}//*[text()='#{title}']/following::div[@class='tree'][#{index}]")
        end
      end

      # Splits string by '->' separator and strip every element in result.
      # @param [String] path_string to split.
      # @return [Array<String>] array of stripped elements returned by split.
      # @example
      #  split_path("Tree head -> tree second level element->tree third level element") #=> ["Tree head", "tree second level element", "tree third level element"]
      def split_path(path_string)
        path_string.split('->').map! { |element| element.strip }
      end

      # Expands all element through path.
      # @param [String,Array<String>] mixpath to target element.
      def navigate(mixpath)
        path = mixpath.is_a?(String) ? split_path(mixpath) : Array.new(mixpath)
        CollapsibleTreeElement.new(@locator, path.shift).navigate(path)
      end

      # Verify that element is inside tree or not.
      # @param (see #navigate).
      # @return [Boolean] true if element found, false otherwise.
      def include?(mixpath, seconds = 2)
        begin
          navigate(mixpath)
          get_element(mixpath).wait(seconds)
        rescue
          false
        end
      end

      # Generate locator of the required element inside the tree.
      # @param (see #navigate).
      # @return [String] XPath locator of the required element.
      def get_element_locator(mixpath)
        path    = mixpath.is_a?(String) ? split_path(mixpath) : Array.new(mixpath)
        locator = "#{@locator}/div[@class='treeNode' and span[text()='#{path.shift}']]"
        path.each do |element|
          locator += "/div[@class='children']//div[@class='treeNode' and span[text()='#{element}']]"
        end
        locator
      end

      # Retrieve element from inside the tree.
      # @param (see #navigate).
      # @return [TreeElement] required element.
      def get_element(mixpath)
        TreeElement.new(get_element_locator(mixpath))
      end

      # Clicks element inside the tree.
      # @param (see #navigate).
      def click_element(mixpath)
        get_element(mixpath).click
      end
    end
  end
end
