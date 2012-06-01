require "douban_core/base_classes/Element"
module WCF
  module Components
  # Base class for simple Forge elements on page.
    class DwrElement < Element
      # Uses {Element#initialize} with additional locator generation options.
      # @param [String, Symbol] how locator if String, initialization modifier if Symbol (:name, :id, :locator, :text, :find).
      # @param [String, nil] what initialization additional information for modifier.
      def initialize(how, what = nil)
        unless what.nil?
          case how
            when :name, :id
              super("//*[@#{how.to_s}='#{what}']")
            when :locator
              super(what)
            when :text
              super("//*[text()='#{what}']")
            when :find
              super("//*[@id=//label[text()='#{what}']/input]")
            else
              raise "Don't know how to init DwrElement by '#{how}' with '#{what}'"
          end
        else
          super(how)
        end
      end
    end
  end
end
