RSpec.describe Dry::Validation do
  describe Dry::Metadata::Fields do
    let(:fields) { described_class.from_validation(schema) }

    describe '.requred?' do
      let(:schema) do
        Dry::Validation.Schema do
          required(:name).filled
        end
      end

      it 'returns true' do
        expect(fields.first.required?).to eq(true)
      end
    end

    describe '.optional?' do
      let(:schema) do
        Dry::Validation.Schema do
          optional(:name).filled
        end
        it 'returns true' do
          expect(fields.last.optional?).to eq(true)
        end
      end
    end
  end
end
