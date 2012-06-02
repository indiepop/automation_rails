module WCF
  module Components

    # Represents button in the application by the name.
    class Button < DwrElement

      # Uses {DwrElement#initialize} with button locator generation options. If only first argument passed - will recognize it
      # as name of the button. Second argument is a parent locator.
      # @note Accepts [enabled] and [disabled] tags to verify state.
      # @param [String] name of button.
      # @param [String] under_locator parent locator.
      def initialize(name, under_locator = nil, index = 1)
        name = name.sub(/\[(disabled|enabled)\]/, "").strip
        additional_conditions = case $1
                                  when "enabled"
                                    "[not(@disabled) and not(contains(@class, 'disabled'))]"
                                  when "disabled"
                                    "[@disabled or contains(@class, 'disabled')]"
                                  else
                                    ""
                                end

        super("#{under_locator}//descendant-or-self::*[(@type='button' or @type='submit' or (contains(@class,'button') and @class!='buttons')) " +
              "and (@value='#{name}' or .//text()='#{name}' or .//*[contains(text(),'#{name}')])][#{index}]#{additional_conditions}")
      end
    end
  end
end