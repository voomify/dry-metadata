RSpec.describe Dry::Validation do
  describe Dry::Metadata::Fields do
    describe 'Reusing Schemas' do
      let(:fields) { described_class.from_validation(schema) }

      let(:schema) do
        address_schema = Dry::Validation.Schema do
          required(:zipcode).filled
        end

        Dry::Validation.Schema do
          required(:address).schema(address_schema)
        end
      end

      it 'has correct types' do
        expect(fields.first[:types]).to eq([:hash?])
      end

      it 'has correct logic' do
        expect(fields.first[:logic]).to eq([:and, [:hash?], [:schema?]])
      end
    end
  end
end
