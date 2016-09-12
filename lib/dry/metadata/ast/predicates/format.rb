module Dry
  module Metadata
    module AST
      module Predicates
        # class that builds up predicate type and logic - for format?
        class Format < Base
          def initialize(field, predicate, attributes)
            super
            add_type!(field, :str?)
            add_logic!(field, [:format?, attributes[:regex]])
          end
        end
      end
    end
  end
end
