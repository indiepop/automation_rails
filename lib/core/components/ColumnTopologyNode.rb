module WCF
  module Components

    # Represents column topology node in the application.
    class ColumnTopologyNode < DwrElement

      # the class variant for mapping the icon file name to the severe level
      @@severe = {
          'mod-fatal'    => 'fatal',
          'mod-critical' => 'critical',
          'mod-warning'  => 'warning',
          'mod-normal'   => 'normal'
      }

      @@type = {
          'vm48.png'                 => 'vm',
          'icn_PhysicalDisks_48.png' => 'physical disks',
          'icn_DataStore_48.png'     => 'data store',
          'dataObject.png'           => 'data object',
          'service16-dark.png'       => 'service',
          'host16.png'               => 'host'
      }

      def initialize(name, under_locator = nil, index = 1)
        super("#{under_locator}//div[@class='columnTopologyNodeLabel' and contains(text(),'#{name}')][#{index}]")
      end

      # @return [String] the name of the topology node
      def name
        wait
        Object.new(@locator).text
      end

      # @return [String] the severe of the topology node
      # will return blank nil if the node does not contain severe icon
      def severe
        scroll_into_view

        result = nil
        @@severe.each do |icon_pattern, value|
          severe_icon = Object.new(locator_to_severe_icon + "[contains(@src, '#{icon_pattern}')]")
          if severe_icon.is_present?
            result = value
            break
          end
        end
        result
      end

      # will hover over the icon of node
      def hover_over_icon
        element = Element.new(locator_to_node_cover)
        $browser.execute_script("var evt = document.createEvent('MouseEvents');" +
                               "evt.initMouseEvent('mouseover',true, true, window, 0, 0, 0, 0, 0, false, false, false, false, 0,null);" +
                               "arguments[0].dispatchEvent(evt);", element.get_element)
      end

      # @return [String] the topology type
      # will return blank nil if the node type can not be retrieved
      def type
        scroll_into_view

        result = nil

        node_icon = Object.new(locator_to_type_icon)
        if node_icon.is_present?
          image_name = node_icon.attribute("src").split('/').last
        else
          return nil
        end

        @@type.each do |name, type|
          if name == image_name
            result = type
            break
          end
        end
        result
      end

    private

      # scroll the node into view
      # by default, the topology does not load the severe icon and type image
      # so this method force refresh the topology node by resizing the browser window
      def scroll_into_view
        node = Object.new(locator_to_node)
        node.click

        script = "window.resizeTo(window.screen.width, window.screen.height); " +
                 "window.resizeTo(window.screen.width, window.screen.height - 50);"

        $browser.execute_script(script)
        $browser.wait_for_element_present(locator_to_type_icon)
      end

      def locator_to_severe_icon
        @locator + "/preceding-sibling::div[3]//img[2]"
      end

      def locator_to_type_icon
        "#{locator_to_node}//img[1]"
      end

      def locator_to_node
        @locator + "/preceding-sibling::div[3]"
      end

      def locator_to_node_cover
        @locator + "/preceding-sibling::div[2]"
      end
    end
  end
end