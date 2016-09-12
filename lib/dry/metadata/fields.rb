module Dry
  module Metadata
    # Provides meta data field information for dry-validation and dry-struct
    class Fields < SimpleDelegator
      attr_reader :fields

      def self.from_validation(validation)
        AST::FieldsCompiler.from_validation(validation, new).freeze
      end

      def self.from_struct(struct)
        AST::FieldsCompiler.from_struct(struct.schema, new).freeze
      end

      def optional_fields
        select(&:optional?)
      end

      def required_fields
        select(&:required?)
      end

      def [](name)
        select { |field| field.name == name }.first
      end

      def to_a
        fields.map(&:to_h)
      end

      private

      def initialize
        @fields = []
        super(@fields)
      end
    end
  end
end
