module Dry
  module Metadata
    module AST
      module Struct
        # builds a validation compatible ast for a structure with a schema
        class Schema < Base
          include Undefined

          def to_ast
            [:and,
             [[:key, [key.to_sym, [:predicate,
                                   [:hash?, [[:input, Undefined]]]]]],
              [:key, [key.to_sym, schema_ast]]]]
          end

          private

          def schema_ast
            [:schema,
             type.schema.map do |skey, value|
               [:and,
                [[:predicate,
                  [:key?, [[:name, key.to_sym],
                           [:input, Undefined]]]],
                 Builder.create(skey, value).to_ast]]
             end]
          end
        end
      end
    end
  end
end
