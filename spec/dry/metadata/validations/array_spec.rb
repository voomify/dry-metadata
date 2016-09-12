RSpec.describe Dry::Validation do
  describe Dry::Metadata::Fields do
    let(:fields) { Dry::Metadata::Fields.from_validation(schema) }

    describe 'Array' do
      describe 'of Schemas' do
        let(:schema) do
          Dry::Validation.Schema do
            each do
              schema do
                required(:name).filled(:str?)
              end
            end
          end
        end

        it 'has correct types' do
          expect(fields.first[:types]).to eq([:array?, [:hash?]])
        end

        it 'has correct logic' do
          expect(fields.first[:logic]).to eq([[:array?], :each, :and,
                                              [:hash?], [:schema?]])
        end
      end
    end
  end
end
