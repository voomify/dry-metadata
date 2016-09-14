RSpec.describe Dry::Validation do
  describe Dry::Metadata::Fields do
    describe 'Required/Optional Keys and Values' do
      let(:fields) { described_class.from_validation(schema) }

      describe 'required key' do
        let(:schema) do
          Dry::Validation.Schema do
            required(:age).filled(:int?, gt?: 18)
          end
        end

        it 'has correct types' do
          expect(fields.first[:required]).to eq(true)
        end
      end

      describe 'optional key' do
        let(:schema) do
          Dry::Validation.Schema do
            optional(:age).filled(:int?, gt?: 18)
          end
        end

        it 'has correct types' do
          expect(fields.first[:required]).to eq(false)
        end
      end

      describe 'optional value' do
        let(:schema) do
          Dry::Validation.Schema do
            optional(:age).maybe(:int?, gt?: 18)
          end
        end

        it 'has correct types' do
          expect(fields.first[:types]).to eq([:none?, :int?])
        end
        it 'has correct logic' do
          expect(fields.first[:logic]).to eq([:if, :not, [:none?],
                                              :and, [:int?], [:gt?, 18]])
        end
      end
    end
  end
end
