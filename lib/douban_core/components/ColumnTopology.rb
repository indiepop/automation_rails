module WCF
  module Components

    # Represents column topology in the application.
    class ColumnTopology < DwrContainer

      def initialize(locator, under_locator = nil, index = 1)
        @locator = locator + "//div[contains(@id, '_topology')][#{index}]"
      end

      # check if the column topology contain the specific node
      def find_node name
        node = ColumnTopologyNode.new(name, @locator)
        node.is_present? ? node : nil
      end
    end
  end
end