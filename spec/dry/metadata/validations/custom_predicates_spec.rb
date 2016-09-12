RSpec.describe Dry::Validation do
  describe Dry::Metadata::Fields do
    describe 'Custom Predicates' do
      let(:fields) { described_class.from_validation(schema) }

      describe 'email?' do
        let(:schema) do
          Dry::Validation.Schema do
            configure do
              def email?(value)
              end
            end

            required(:email).filled(:str?, :email?)
          end
        end

        it 'has correct types' do
          expect(fields.first[:types]).to eq([:str?])
        end

        it 'has correct logic' do
          expect(fields.first[:logic]).to eq([:and, :and, [:filled?],
                                              [:str?], [:email?]])
        end
      end
    end
  end
end
