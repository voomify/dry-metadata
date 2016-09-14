RSpec.describe Dry::Validation do
  describe Dry::Metadata::Fields do
    describe 'Macros' do
      let(:fields) { described_class.from_validation(schema) }

      describe 'filled' do
        let(:schema) do
          Dry::Validation.Schema do
            # expands to `required(:age) { filled? & int? }`
            required(:age).filled(:int?)
          end
        end

        it 'has correct types' do
          expect(fields.first[:types]).to eq([:int?])
        end

        it 'has correct logic' do
          expect(fields.first[:logic]).to eq([:and, [:filled?], [:int?]])
        end
      end

      describe 'maybe' do
        let(:schema) do
          Dry::Validation.Schema do
            # expands to `required(:age) { none? | int? }`
            required(:age).maybe(:int?)
          end
        end

        it 'has correct types' do
          expect(fields.first[:types]).to eq([:none?, :int?])
        end
        it 'has correct logic' do
          expect(fields.first[:logic]).to eq([:if, :not, [:none?], [:int?]])
        end
      end

      describe 'each' do
        let(:schema) do
          Dry::Validation.Schema do
            # expands to: `required(:tags) { array? { each { str? } } }`
            required(:tags).each(:str?)
          end
        end

        it 'has correct types' do
          expect(fields.first[:types]).to eq([:array?, [:str?]])
        end
        it 'has correct logic' do
          expect(fields.first[:logic]).to eq([:and, [:array?], :each, [:str?]])
        end
      end

      describe 'when' do
        let(:schema) do
          Dry::Validation.Schema do
            # expands to:
            #
            # rule(email: [:login])
            # { |login| login.true?.then(value(:email).filled?) }
            #
            required(:email).maybe

            required(:login).filled(:bool?).when(:true?) do
              value(:email).filled?
            end
          end
        end

        it 'has correct types' do
          expect(fields.first[:types]).to eq([:none?])
        end
        it 'has correct logic' do
          expect(fields.first[:logic]).to eq([:if, :not, [:none?], [:filled?]])
        end
      end

      describe 'confirmation' do
        let(:schema) do
          Dry::Validation.Schema do
            # expands to:
            #
            # rule(password_confirmation: [:password]) do |password|
            #   value(:password_confirmation).eql?(password) }
            # end
            #
            required(:password).filled(min_size?: 12).confirmation
          end
        end

        it 'password types' do
          expect(fields.first[:types]).to eq([])
        end

        it 'password logic' do
          expect(fields.first[:logic]).to eq([:and, [:filled?],
                                              [:min_size?, 12]])
        end

        it 'password_confirmation types' do
          expect(fields.last[:types]).to eq([:none?])
        end
        it 'password_confirmation logic' do
          expect(fields.last[:logic]).to eq([:if, :not, [:none?], [:filled?]])
        end
      end
    end
  end
end
