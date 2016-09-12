module Dry
  module Metadata
    module AST
      module Predicates
        # class that builds up predicate logic - for memberships predicates
        # (included_in?, excluded_from?)
        class Membership < Base
          def initialize(field, predicate, attributes)
            super
            list = attributes[:list]
            list.each do |list_value|
              type = TYPES[list_value.class]
              add_type!(field, type)
            end
            add_logic!(field, [predicate, list])
          end
        end
      end
    end
  end
end
