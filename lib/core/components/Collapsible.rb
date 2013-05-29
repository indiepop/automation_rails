module WCF
  module Components

    # Represents collapsible trees in the application by the name.
    class Collapsible < DwrContainer
      # Uses {DwrContainer#initialize} with collapsible tree locator generation options.
      # @param [String] name of the collapsible tree.
      def initialize(name)
        super("//div[div[@class='collapsibleHeader' and label[text()='#{name}']]]")
      end

      # Verify whether collapsible tree expanded or collapsed.
      # @return [Boolean] true if expanded, false otherwise.
      # @note Performs {#wait} before acting.
      def is_expanded?
        wait
        $browser.is_element_present("#{@locator}/div[@class='collapsibleBody' and not(contains(@style,'display: none'))]")
      end

      # Expand collapsible tree with {#toggle} if it is collapsed.
      # @return [nil] if no action permitted.
      def expand
        is_expanded? ? nil : toggle
      end

      # Collapse collapsible tree with {#toggle} if it is expanded.
      # @return [nil] if no action permitted.
      def collapse
        is_expanded? ? toggle : nil
      end

      # Clicks on the down or right arrow near the collapsible tree name.
      # @note (see #is_expanded?)
      def toggle
        wait
        $browser.find_element(:xpath, "#{@locator}/div[@class='collapsibleHeader']/img").click
      end
    end
  end
end

