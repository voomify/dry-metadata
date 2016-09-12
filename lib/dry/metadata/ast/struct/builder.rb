module Dry
  module Metadata
    module AST
      module Struct
        # Builds a dry logic abstact syntax tree (AST) for a Dry::Struct
        # Used by the FieldsCompiler
        # Note: This a TEMPORARY ast transformation
        # It allow the metadata fields compiler to work with dry-v and dry-s
        # Once Dry::Struct schema is symetrical with
        # Dry::Validation schema all this code goes away
        class Builder
          include Undefined
          attr_reader :rules_ast

          def self.rules_ast(struct_schema)
            new(struct_schema).rules_ast
          end

          def self.create(key, type)
            Struct::Factory.create(key, type)
          end

          private

          def initialize(schema)
            @rules_ast = schema.map do |key, value|
              [:and, [[:val, [:predicate, [:key?, [[:name, key.to_sym],
                                                   [:input, Undefined]]]]],
                      Builder.create(key, value).to_ast]]
            end
          end
        end
      end
    end
  end
end
