module Dry
  module Metadata
    module AST
      module Predicates
        # class that builds up predicate type and logic - for type?(:int?)
        class Type < Base
          def initialize(field, predicate, attributes)
            super
            value_equals = attributes[:type]
            add_type!(field, TYPES[value_equals])
            add_logic!(field, [TYPES[value_equals]])
          end
        end
      end
    end
  end
end
