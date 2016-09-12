module Dry
  module Metadata
    module AST
      module Struct
        # builds a dry-validation compatible ast for a dry-struct left
        class Left < Base
          def to_ast
            [:or, [[:key, [key.to_sym,
                           Builder.create(key, type.left).to_ast]],
                   [:key, [key.to_sym,
                           Builder.create(key, type.right).to_ast]]]]
          end
        end
      end
    end
  end
end
