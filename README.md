# Dry::Metadata

WIP

Provides field level metadata for [Dry-Validation](https://github.com/dry-rb/dry-validation) and [Dry-Struct](https://github.com/dry-rb/dry-struct).

Possible uses include the following:

* Form builders
* API builders
* Test Automation
* Generators
* Client side javascript (partial) validations

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dry-metadata'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dry-metadata

## Usage

### With Dry Validation

```ruby
require 'dry-validation'

UserSchema = Dry::Validation.Schema do
  required(:name).filled
  required(:age).maybe(:int?)
  required(:address).schema do
    required(:street).filled
    required(:city).filled
    optional(:zipcode).filled
  end
end

fields = Dry::Metadata::Fields.from_validation(UserSchema)
```

### With Dry Struct
This is experimental - not all cases have been spec'ed yet. Please report any issues you find.
```ruby
require 'dry-struct'
module Types
    include Dry::Types.module
end

class Address < Dry::Types::Struct
    attribute :street, Types::Strict::String
    attribute :city, Types::Strict::String
    attribute :zipcode, Types::Strict::String.optional
end

class UserStruct < Dry::Types::Struct
    attribute :name, Types::Strict::String
    attribute :age,  Types::Strict::Int
    attribute :address, Address
end

fields = Dry::Metadata::Fields.from_struct(UserStruct)
```

### Metadata Fields Interface
```ruby
fields.each do |field|
    puts field.name      # the name of the field
    puts field.required? # if the field is required
    puts field.optional? # if the field is !required
    puts field.types     # the array of valid types
    puts field.logic     # polish notation of the logic (minus custom rules)
    puts field.fields    # nested fields or []
end

# To fetch all required fields:
fields.required_fields

# To fetch all optional fields:
fields.optional_fields

# To fetch a single field by name:
fields[:age]

# To sort by name:
fields.sort

# To get a arrary of hash representations suitable to serialize:
fields.to_a
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/voomify/dry-metadata.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

