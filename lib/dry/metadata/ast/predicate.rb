module Dry
  module Metadata
    module AST
      # class that builds up predicate logic - used by fields_compiler
      class Predicate
        include TypeMap

        PREDICATE_MAP = { eql?: AST::Predicates::Equality,
                          not_eql?: AST::Predicates::Equality,
                          key?: AST::Predicates::Key,
                          empty?: AST::Predicates::Unary,
                          filled?: AST::Predicates::Unary,
                          format?: AST::Predicates::Format,
                          size?: AST::Predicates::Size,
                          even?: AST::Predicates::Parity,
                          odd?: AST::Predicates::Parity,
                          included_in?: AST::Predicates::Membership,
                          excluded_from?: AST::Predicates::Membership,
                          excludes?: AST::Predicates::Contents,
                          includes?: AST::Predicates::Contents,
                          type?: AST::Predicates::Type,
                          max_size?: AST::Predicates::ElementComparitor,
                          min_size?: AST::Predicates::ElementComparitor,
                          gt?: AST::Predicates::CardinalComparitor,
                          gteq?: AST::Predicates::CardinalComparitor,
                          lt?: AST::Predicates::CardinalComparitor,
                          lteq?: AST::Predicates::CardinalComparitor }.merge(
                            Hash[TYPES.values.map do |type|
                              [type, AST::Predicates::Types]
                            end]
                          ).freeze

        def self.add!(field, predicate, attributes)
          if PREDICATE_MAP.key?(predicate)
            PREDICATE_MAP[predicate].new(field, predicate, attributes)
          else
            AST::Predicates::Custom.new(field, predicate, attributes)
          end
        end
      end
    end
  end
end
