module Dry
  module Metadata
    module AST
      module Struct
        # builds a dry-validation compatible ast for a dry-struct rule
        class Rule < Base
          def to_ast
            [:key, [key.to_sym, type.rule.to_ast]]
          end
        end
      end
    end
  end
end
