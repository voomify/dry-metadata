module Dry
  module Metadata
    module AST
      module Predicates
        # class that builds up predicate logic - for unary prediates
        # (empty?, filled?)
        class Unary < Base
          def initialize(field, predicate, attributes)
            super
            add_logic!(field, [predicate])
          end
        end
      end
    end
  end
end
