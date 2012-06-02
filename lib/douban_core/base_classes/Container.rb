
require "douban_core/base_classes/Object"
module WCF
  module Components

    # Base class for containers on page.
    # Containers can have other containers or elements inside.
    class Container < Object

      # Populate input fields of the container with provided values.
      # @param [table] table table of *key* *value* pairs.
      # @raise [RuntimeError] if cannot find field with specified *key*.
      # @note Cannot be used by Container instance itself, only subclasses.
      # @note Performs {#wait} before acting.
      # @see https://github.com/cucumber/cucumber/blob/master/lib/cucumber/ast/table.rb#L131 rows_hash
      def fill(table)
        if self.instance_of?(Container)
          raise "fill(table) method cannot be used by Container instance itself.
                 Use it by Container subclasses."
        end
        wait
        table.rows_hash.each do |key, value|
          field_alignment = 'left'

          actual_key = key
          if key =~ /^\[right\](?:.*)|(?:.*)\[right\]$/
            actual_key = key.sub('[right]', '')
            field_alignment = 'right'
          end
          set_value(actual_key, value, field_alignment)
        end
      end
    end
  end
end
