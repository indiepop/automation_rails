module WCF
  module Components

    class MenuBox < DwrElement
      def initialize(name, under_locator = nil)
        super("#{under_locator}//div[contains(@class,'history')]/span[text()='#{name}']")
      end

      def select(option)
        $browser.wait_for_element_present(locator = "//div/span[@title='Show history']")
        $browser.click_at(locator, "1,1")
        if option == "Storage Explorer"
          $browser.wait_for_element_present(locator = "//div/ul[@class='popupMenu']/li[text()='#{option}']")
        else
          $browser.wait_for_element_present(locator = "//div/ul[@class='popupMenu']/li/span[text()='#{option}']")
        end
        $browser.click_at(locator, "1,1")
      end
    end
  end
end
