RSpec.describe Dry::Validation do
  describe Dry::Metadata::Fields do
    describe 'Dynamic Predicate Arguments' do
      let(:fields) { described_class.from_validation(schema) }

      let(:schema) do
        Dry::Validation.Schema do
          configure do
            def data
              %w(a b c)
            end
          end

          required(:letter).filled(included_in?: data)
        end
      end

      it 'has correct types' do
        expect(fields.first[:types]).to eq([:str?])
      end

      it 'has correct logic' do
        expect(fields.first[:logic]).to eq([:and, [:filled?],
                                            [:included_in?, %w(a b c)]])
      end
    end
  end
end
