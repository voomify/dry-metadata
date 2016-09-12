module Dry
  module Metadata
    module AST
      module Struct
        # base class for ast builders
        class Base
          attr_reader :type
          attr_reader :key

          def initialize(key, type)
            @key = key
            @type = type
          end

          def to_ast
            raise 'Not implemented'
          end
        end
      end
    end
  end
end
