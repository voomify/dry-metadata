module Dry
  module Metadata
    module AST
      module Predicates
        # class that builds up predicate logic - for parity prediates
        # (event?, odd?)
        class Parity < Base
          def initialize(field, predicate, attributes)
            super
            add_type!(field, :int?)
            add_logic!(field, [predicate])
          end
        end
      end
    end
  end
end
