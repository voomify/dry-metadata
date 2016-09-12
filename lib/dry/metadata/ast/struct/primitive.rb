module Dry
  module Metadata
    module AST
      module Struct
        # builds a dry-validation compatible ast for a dry-struct privitive
        class Primitive < Base
          include TypeMap
          def to_ast
            [:key, [key.to_sym, [:predicate, [TYPES[type.primitive],
                                              [[:input, Undefined]]]]]]
          end
        end
      end
    end
  end
end
