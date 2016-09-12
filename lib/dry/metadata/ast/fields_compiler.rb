module Dry
  module Metadata
    module AST
      # Walks the dry logic abstract syntax tree (AST) building fields
      # depends on Field and used by Fields
      class FieldsCompiler
        attr_reader :fields

        def self.from_validation(schema, fields)
          build_fields(Validation::Builder.rules_ast(schema), fields)
        end

        def self.from_struct(schema, fields)
          build_fields(Struct::Builder.rules_ast(schema), fields)
        end

        def self.build_fields(rules_ast, fields)
          new(rules_ast, fields).fields
        end

        private

        def initialize(rules_ast, fields)
          @fields = fields
          traverse(rules_ast, fields)
        end

        def traverse(rules_ast, fields)
          rules_ast.each do |rule_ast|
            field = { name: :none, types: [] }
            visit(rule_ast, field)
            fields.push(Field.new(field))
          end
        end

        def visit(rule_ast, field)
          __send__(:"visit_#{rule_ast.first}", rule_ast.last, field)
        end

        def visit_and(rule_ast, field)
          push_value_logic!(field, :and) unless mark_required_once!(field, true)

          visit(rule_ast.first, field)
          visit(rule_ast.last, field)
        end

        def visit_implication(rule_ast, field)
          push_value_logic!(field, :if) unless mark_required_once!(field, false)

          visit(rule_ast.first, field)
          visit(rule_ast.last, field)
        end

        def visit_predicate(rule_ast, field)
          predicate = rule_ast.first
          attributes = [rule_ast.last.first].to_h
          add_predicate!(field, predicate, attributes)
        end

        def visit_or(rule_ast, field)
          push_value_logic!(field, :or)
          visit(rule_ast.first, field)
          visit(rule_ast.last, field)
        end

        def visit_val(rule_ast, field)
          visit(rule_ast, field)
        end

        def visit_key(rule_ast, field)
          visit(rule_ast.last, field)
        end

        def visit_schema(rule_ast, field)
          field[:fields] = Metadata::Fields.new
          add_logic_argument!(field, [:schema?])
          traverse(rule_ast, field[:fields])
        end

        def visit_xor(rule_ast, field)
          push_value_logic!(field, :xor)
          visit(rule_ast.first, field)
          visit(rule_ast.last, field)
        end

        def visit_each(rule_ast, field)
          push_value_logic!(field, :each)
          visit(rule_ast, field)
        end

        def visit_not(rule_ast, field)
          push_value_logic!(field, :not)
          visit(rule_ast, field)
        end

        def visit_set(_rule_ast, _field)
          raise 'missing implementation'
        end

        def mark_required_once!(field, is_required)
          first_time = !field.key?(:required)
          field[:required] = is_required if first_time
          first_time
        end

        def push_value_logic!(field, operator)
          add_logic_argument!(field, operator)
        end

        def add_predicate!(field, predicate, attributes)
          AST::Predicate.add!(field, predicate, attributes)
        end

        def add_logic_argument!(value, predicate)
          value[:logic] ||= []
          value[:logic] << predicate
        end
      end
    end
  end
end
