module WCF
  module Components

    # Represents framed boxes in the application by the title.
    class Dialog < DwrContainer

      # Uses {DwrContainer#initialize} with framed box locator generation options.
      # @param [String] title of the framed box.
      # @param [String] under_locator locator of the parent container.
      def initialize(title = nil, under_locator = nil, index = 1)
        super("#{under_locator}//div[@id='prmPopupContainer']/div[contains(@class,'dialog') and div[@class='header']/div[@class='title' and (.//text()=#{generate_concat_for_xpath_text title} or contains(.,#{generate_concat_for_xpath_text title}) or .//*[contains(text,#{generate_concat_for_xpath_text title})])]][#{index}]")
      end

   # Get all titles of Dialog's on the screen.
      # @return [Array<String>] list of all Dialog's titles on the screen.
      def self.get_boxes_title
        result = []
        $browser.get_xpath_count(locator = "//div[@id='prmPopupContainer']/div[contains(@class,'dialog') and not(ancestor::div[contains(@class,'dialog')])]").to_i.times do |index|
          result << $browser.get_text("#{locator}[#{index+1}]/div[@class='header']/div[@class='title']")
          $browser.get_xpath_count("#{locator}[#{index+1}]//div[@id='prmPopupContainer']/div[contains(@class,'dialog')]").to_i.times do |sub_index|
            result << " #{$browser.get_text("#{locator}[#{index+1}]//div[@id='prmPopupContainer']/div[contains(@class,'dialog')][#{sub_index+1}]/div[@class='header']/div[@class='title']")}"
          end
        end
        result
      end

      # Click control buttons on top-right corner of dialog.
      # @param [String] title of the button to click.
      # @see Element#click
      def click_control_button(title)
        $browser.wait_for_body_text
        begin
          Element.new("#{@locator}//div[@class='controls']/img[@title=#{generate_concat_for_xpath_text title}]").click
        rescue RuntimeError
          raise "Button with '#{title}' title isn't found. Usual buttons is: Close, Maximize, Restore."
        end
      end
    end
  end
end
