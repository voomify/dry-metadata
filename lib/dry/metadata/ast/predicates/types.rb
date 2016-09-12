module Dry
  module Metadata
    module AST
      module Predicates
        # class that builds up predicate type and logic - for types
        # (int?, str?, ...)
        class Types < Base
          def initialize(field, predicate, attributes)
            super
            add_type!(field, predicate)
            add_logic!(field, [predicate])
          end
        end
      end
    end
  end
end
