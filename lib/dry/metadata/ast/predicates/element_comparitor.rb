module Dry
  module Metadata
    module AST
      module Predicates
        # class that builds up predicate logic - for contains predicates
        # (includes?, excludes?)
        class ElementComparitor < Base
          def initialize(field, predicate, attributes)
            super
            value_equals = attributes[:num]
            add_logic!(field, [predicate, value_equals])
          end
        end
      end
    end
  end
end
