module Dry
  module Metadata
    module AST
      module Predicates
        # class that builds up predicate logic - for equality
        # (eql? and not_eql?)
        class Key < Base
          def initialize(field, predicate, attributes)
            super
            field[:name] = attributes[:name]
          end
        end
      end
    end
  end
end
