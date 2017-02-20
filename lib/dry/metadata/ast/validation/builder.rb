module Dry
  module Metadata
    module AST
      module Validation
        # Builds a recursive rules_ast for validation schemas
        class Builder
          attr_reader :rules_ast

          def self.rules_ast(validation)
            new(validation).rules_ast
          end

          private

          def initialize(validation)
            @rules_ast = explode_rules_ast(
              validation.rules.map do |_, value|
                value.ast(nil)
              end
            )
          end

          def explode_rules_ast(rules_ast)
            rules_ast.each_with_index.map do |rule_ast, index|
              if rule_ast.respond_to?(:each_index)
                explode_rules_ast(rule_ast)
              elsif rules_ast.respond_to?(:each_index) && rules_ast[index - 1] == :schema
                explode_rules_ast(rules_ast[index].rule_ast)
              else
                rule_ast
              end
            end
          end
        end
      end
    end
  end
end
