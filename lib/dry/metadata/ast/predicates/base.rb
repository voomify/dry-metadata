module Dry
  module Metadata
    module AST
      module Predicates
        # class that builds up predicate logic - used by fields_compiler
        class Base
          include TypeMap
          def initialize(field, predicate, attributes)
            @field = field
            @predicate = predicate
            @attributes = attributes
          end

          private

          attr_reader :field, :predicate, :attributes

          def add_type!(value, type)
            types = value[:types] ||= []
            if each?(value)
              types = []
              value[:types] << types
            end
            types << type unless value[:types].include?(type)
          end

          def add_logic!(value, predicate)
            value[:logic] ||= []
            value[:logic] << predicate
          end

          def each?(value)
            return false unless value[:logic]
            last_two_elements = value[:logic][-2..-1]
            last_two_elements && last_two_elements.include?(:each)
          end
        end
      end
    end
  end
end
