module Dry
  module Metadata
    module AST
      module Predicates
        # class that builds up predicate logic - for equality eql? and not_eql?
        class Equality < Base
          def initialize(field, predicate, attributes)
            super
            value_equals = attributes[:left]
            add_type!(field, TYPES[value_equals.class])
            add_logic!(field, [predicate, value_equals])
          end
        end
      end
    end
  end
end
