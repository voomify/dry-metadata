$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'dry-types'
require 'dry-struct'
require 'dry-validation'
require 'dry-metadata'

require 'pathname'

module DryMetadataSpec
  ROOT = Pathname.new(__dir__).parent.expand_path.freeze
end

# $VERBOSE = true
