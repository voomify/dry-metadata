RSpec.describe Dry::Validation do
  describe Dry::Metadata::Fields do
    describe 'Nested Data' do
      let(:fields) { described_class.from_validation(schema) }

      describe 'Nested Hash' do
        let(:schema) do
          Dry::Validation.Schema do
            required(:nested_name).schema do
              required(:name).value(type?: String)
            end
          end
        end

        it ':nested_name, :type' do
          expect(fields.first[:types]).to eq([:hash?])
        end

        it ':nested_name, :logic' do
          expect(fields.first[:logic]).to eq([:and, [:hash?], [:schema?]])
        end

        it ':nested_name, :name, :type' do
          expect(fields.first[:fields].first[:types]).to eq([:str?])
        end

        it ':nested_name, :name, :logic' do
          expect(fields.first[:fields].first[:logic]).to eq([[:str?]])
        end
      end
    end
  end
end
