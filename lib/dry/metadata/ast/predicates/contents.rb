module Dry
  module Metadata
    module AST
      module Predicates
        # class that builds up predicate logic - for contains predicates
        # (includes?, excludes?)
        class Contents < Base
          def initialize(field, predicate, attributes)
            super
            exclude_value = attributes[:value]
            list = *exclude_value
            list.each do |list_value|
              type = TYPES[list_value.class]
              add_type!(field, type)
            end
            add_logic!(field, [predicate, exclude_value])
          end
        end
      end
    end
  end
end
