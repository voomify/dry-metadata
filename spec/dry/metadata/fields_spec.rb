RSpec.describe Dry::Metadata::Fields do
  let(:schema) do
    Dry::Validation.Schema do
      required(:required_field).filled
      optional(:optional_field).filled
    end
  end
  let(:fields) { described_class.from_validation(schema) }

  describe 'optional_fields' do
    let(:optional_fields) { fields.optional_fields }

    it 'returns one field' do
      expect(fields.optional_fields.size).to eq(1)
    end

    it 'returns correct optional key name' do
      expect(fields.optional_fields.first.name).to eq(:optional_field)
    end
  end

  describe 'required_fields' do
    let(:required_fields) { fields.required_fields }

    it 'returns one field' do
      expect(required_fields.size).to eq(1)
    end

    it 'returns correct optional key name' do
      expect(required_fields.first.name).to eq(:required_field)
    end
  end

  describe 'sorts' do
    let(:sorted) { fields.sort }

    it 'returns a sorted by name' do
      expect(sorted.first.name).to eq(:optional_field)
      expect(sorted.last.name).to eq(:required_field)
    end
  end

  describe '[](:name)' do
    let(:field) { fields[:optional_field] }

    it 'returns the correct field' do
      expect(field.name).to eq(:optional_field)
    end
  end

  describe 'to_a' do
    let(:arrary) { fields.to_a }

    it 'returns an arrary of hashes' do
      expect(arrary).to eq([{ name: :required_field,
                              required: true,
                              types: [],
                              logic: [[:filled?]],
                              fields: [] },
                            { name: :optional_field,
                              required: false,
                              types: [],
                              logic: [[:filled?]],
                              fields: [] }])
    end

    context 'nested schema' do
      let(:schema) do
        Dry::Validation.Schema do
          required(:nested_name).schema do
            required(:name).value(type?: String)
          end
        end
      end

      it 'returns an arrary of hashes with nesting' do
        expect(arrary).to eq([{ name: :nested_name,
                                required: true,
                                types: [:hash?],
                                logic: [:and, [:hash?], [:schema?]],
                                fields: [{ name: :name,
                                           required: true,
                                           types: [:str?],
                                           logic: [[:str?]], fields: [] }] }])
      end
    end
  end
end
