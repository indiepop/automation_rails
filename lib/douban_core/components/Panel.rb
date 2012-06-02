module WCF
  module Components

    # Represents panel in the application by the title.
    class Panel < DwrContainer

      # Uses {DwrContainer#initialize} with panel locator generation options.
      # @param [String] title of the panel.
      # @param [String] under_locator locator of the parent container.
      def initialize(title = nil, under_locator = nil, index = 1)
        super("#{under_locator}//descendant-or-self::div[@class='framedBox' or @class='framedBox collapsed' and div[@class='header']/div[@class='title' and contains(.,'#{title}')]][#{index}]")
      end

      # Get all titles of panel's on the screen.
      # @return [Array<String>] list of all panel's titles on the screen.
      def self.get_panel_title
        result = []
        $browser.get_xpath_count(locator = "//div[@class='framedBox' or @class='framedBox collapsed' and not(ancestor::div[@class='framedBox'])]").to_i.times do |index|
          result << $browser.get_text("#{locator}[#{index+1}]/div[@class='header']/div[@class='title']")
          $browser.get_xpath_count("#{locator}[#{index+1}]//div[@class='framedBox']").to_i.times do |sub_index|
            result << " #{$browser.get_text("#{locator}[#{index+1}]//div[@class='framedBox' or @class='framedBox collapsed' ][#{sub_index+1}]/div[@class='header']/div[@class='title']")}"
          end
        end
        result
      end

      # Click control buttons on top-right corner of box.
      # @param [String] title of the button to click.
      # @see Element#click
      def click_control_button(title)
        begin
          Element.new("#{@locator}//div[@class='controls']/img[@title='#{title}']").click
        rescue RuntimeError
          raise "Button with '#{title}' title isn't found. Usual buttons is: Collapse,Expand,Help"
        end
      end
    end
  end
end
