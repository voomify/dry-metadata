module Dry
  module Metadata
    module AST
      module Predicates
        # class that builds up predicate logic - for unary prediates
        # (empty?, filled?)
        class Size < Base
          def initialize(field, predicate, attributes)
            super
            value_equals = attributes[:size]
            add_logic!(field, [predicate, value_equals])
          end
        end
      end
    end
  end
end
