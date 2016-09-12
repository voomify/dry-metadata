# A factory to create AST builder objects.
# Used by the Builder
module Dry
  module Metadata
    module AST
      module Struct
        # class creates ast building classes from dry-struct types
        class Factory
          DRY_TYPE_TO_AST = { Dry::Types::Constrained => Struct::Rule,
                              Dry::Types::Sum::Constrained => Struct::Rule,
                              Dry::Types::Sum => Struct::Left,
                              Dry::Types::Definition =>
                                  Struct::Primitive }.freeze

          def self.create(key, type)
            if DRY_TYPE_TO_AST.key?(type.class)
              DRY_TYPE_TO_AST[type.class].new(key, type)
            elsif type.respond_to?(:schema)
              Struct::Schema.new(key, type)
            else
              raise "Unknown type. Can not convert to ast. #{type}"
            end
          end
        end
      end
    end
  end
end
