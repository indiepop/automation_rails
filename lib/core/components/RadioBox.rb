module WCF
  module Components

    # Represents radiobox in the application.
    class RadioBox < DwrElement
      def initialize(name, under_locator = nil, index = 1)
        name = name.sub(/\[(left|right)\]/, "").strip
        add_condition = case $1
                          when "left"
                            "label[contains(text(), '#{name}')]/following-sibling::"
                          when "right"
                            "label[contains(text(), '#{name}')]/preceding-sibling::"
                          else
                            "label[contains(text(), '#{name}')]/preceding-sibling::"
                        end
        super("#{under_locator}//#{add_condition}input[@type='radio']")
      end

      # Verify whether radiobox checked or not.
      # @note Performs {#wait} before acting.
      # @return [Boolean] true if checked, false if not.
      def get_value
        wait
        super.is_present?("#{@locator}[@checked='checked']")
      end
    end
  end
end
