module WCF
  module Components
    class LegacyTrees < Element
      def initialize
        super("//div[@class='x-tree-root-node']")
      end

      def navigate_to path
        paths = path.split('->').map { |item| item.strip }
        locator = @locator + "/"
        paths.each do |path|
          path_locator = "#{locator}li[@class='x-tree-node' and .//a[span[text()='#{path}']]]"
          puts path_locator
          if Object.new("#{path_locator}").is_present?
            collapsed_element = Object.new("#{path_locator}/div[contains(@class,'x-tree-node-collapsed')]/img")
            node_element = Object.new("#{path_locator}//a")
            puts "^^^^^^^^^^^^^^^^^ in ^^^^^^^^"
            if collapsed_element.is_present?
              puts "*************collapsed: " +  collapsed_element.get_locator
              collapsed_element.click
              $browser.wait_for_body_text
            elsif node_element.is_present?
              puts "***************node: " +  node_element.get_locator
              node_element.click
            end
            locator += "li[@class='x-tree-node' and .//a[span[text()='#{path}']]]//"
          end
        end
      end
    end
  end
end