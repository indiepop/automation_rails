module WCF
  module Components

    # Represents column topology group node in the application.
    class ColumnTopologyGroupNode < DwrElement

      # the class variant for mapping the icon file name to the severe level
      @@severe = {
          'mod-fatal'    => 'fatal',
          'mod-critical' => 'critical',
          'mod-warning'  => 'warning',
          'mod-normal'   => 'normal'
      }

      @@type = {
          'esxhost32.png'      => 'host group box',
          'service16-dark.png' => 'service group box'
      }

      def initialize(name, under_locator = nil, index = 1)
        super("#{under_locator}//div[@class='columnTopologyGroupNode border']//div[@title='#{name}' and text()='#{name}'][#{index}]")
      end

      # @return [String] the name of the topology node
      def name
        Object.new(@locator).text
      end

      # @return [String] the severe of the group box
      # will return blank nil if the node does not contain severe icon
      def severe
        # TODO
      end

      # @return [String] the group box type
      # will return blank nil if the node type can not be retrieved
      def type
        result = nil
        element = Object.new(locator_to_type_icon)
        if element.is_present?
          image_name = element.attribute("src").split('/').last
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

      def locator_to_severe_icon
        @locator + "/preceding-sibling::div[1]//img[2]"
      end

      def locator_to_type_icon
        @locator + "/preceding-sibling::div[1]//img[1]"
      end
    end
  end
end