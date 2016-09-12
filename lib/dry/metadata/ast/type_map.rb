require 'bigdecimal'

module Dry
  module Metadata
    module AST
      module TypeMap
        TYPES = { NilClass => :none?,
                  TrueClass => :bool?,
                  String => :str?,
                  Fixnum => :int?,
                  Float => :float?,
                  BigDecimal => :decimal?,
                  Date => :date?,
                  DateTime => :date_time?,
                  Time => :time?,
                  Hash => :hash?,
                  Array => :array? }.freeze
      end
    end
  end
end
