module WCF
  module Components

    # Represents {Collapsible} elements.
    class CollapsibleTreeElement < DwrElement
      # Uses {DwrElement#initialize} with {Collapsible} element locator generation options.
      # @param [String] tree_locator locator of the parent {Collapsible}.
      # @param [String] title 1st level element under parent {Collapsible}.
      # @example title
      #   "Agents"
      def initialize(tree_locator, title)
        super("#{tree_locator}/div[@class='treeNode' and span[text()='#{title}']]")
        @path = [title]
      end

      # Verify whether element expanded or collapsed.
      # @return [Boolean] true if expanded, false otherwise.
      # @note Performs {#wait} before acting.
      def is_expanded?
        wait
        $browser.is_element_present("#{@locator}[div[@class='children' and not(contains(@style,'display: none'))]]")
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
        Element.new("#{@locator}/img").click_at
      end

      # Expands all element through path.
      # @param [Array<String>] path to target element.
      # @raise [RuntimeError] if some element of the path cannot be expanded or found.
      def navigate(path)
        unless path.empty?
          begin
            expand
          rescue RuntimeError
            raise "Collapsible tree element with #{@path.join('->')} path can't be expanded"
          end
          @path.push(path.shift)
          @locator += "/div[@class='children']/div[@class='treeNode' and span[text()='#{@path.last}']]"
          navigate(path)
        end
      end
    end
  end
end
