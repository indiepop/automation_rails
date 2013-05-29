module WCF
  module Components

    # Represents checkbox in the application usually by the label near to it.
    class CheckBox < DwrElement

      # Uses {DwrElement#initialize} with checkbox locator generation options. If only first argument passed - will recognize it
      # as label for the checkbox. If second argument is not :text or :locator - will recognize it as parent locator.
      # @param [String, Symbol] how label of checkbox if String, initialization modifier if Symbol (:text, :locator).
      # @param [String] what initialization additional information for modifier or parent locator.
      def initialize(how, what=nil, index = 1)
        if (not what.nil?)
          case how
            when :text
              super("//label[contains(.,'#{what}')]/input[@type='checkbox'][#{index}]")
            when :locator
              super(what)
            else
              super("#{what}//label[contains(.,'#{how}')]/input[@type='checkbox'][#{index}]")
          end
        else
          if Object.new("//label[contains(.,'#{how}')]/input[@type='checkbox'][#{index}]").is_present?
            super("//label[contains(.,'#{how}')]/input[@type='checkbox'][#{index}]")
          else
            super("//label[contains(.,'#{how}')]/following::input[@type='checkbox'][#{index}]")
          end

        end
      end

      # Checks the checkbox using {#toggle} if it is not checked yet.
      # @return [nil] if no action permitted.
      def check
        toggle unless is_checked?
      end

      alias :select :check

      # Unchecks the checkbox using {#toggle} if it is checked.
      # @return (see #check)
      def uncheck
        toggle if is_checked?
      end

      # Verify whether checkbox checked or not.
      # @note Performs {#wait} before acting.
      # @return [Boolean] true if checked, false if not.
      def is_checked?
        wait
        $browser.find_element(:xpath, @locator).selected?
      end

      alias :get_value :is_checked?

      # Clicks on the checkbox.
      # @note (see #is_checked?)
      # @param [String] value value that represents additional logic: 'on' or 'check' will {#check} checkbox,
      #  'off' or 'uncheck' will {#uncheck} checkbox. Any other will permit standard action.
      # @return (see #check)
      def toggle(value = "toggle")
        wait
        case value.downcase
          when "on", "check"
            check
          when "off", "uncheck"
            uncheck
          else
            $browser.find_element(:xpath, @locator).click
        end
      end
    end
  end
end
