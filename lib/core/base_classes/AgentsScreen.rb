module WCF
  module Components

    # Represents special cases on Agents screen.
    class AgentsScreen < Screen
      def initialize
        super("Agents")

        @fieldname = {
          "SearchBox" => ["class", "textFilter"]
        }
      end
    end
  end
end