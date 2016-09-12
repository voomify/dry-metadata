RSpec.describe Dry::Validation do
  describe Dry::Metadata::Fields do
    describe 'Predicate Logic' do
      let(:fields) { described_class.from_validation(schema) }

      describe 'Conjunction (&)' do
        let(:schema) do
          Dry::Validation.Schema do
            required(:age) { int? & gt?(18) }
          end
        end

        it'has correct types' do
          expect(fields.first[:types]).to eq([:int?])
        end

        it 'has correct logic' do
          expect(fields.first[:logic]).to eq([:and, [:int?], [:gt?, 18]])
        end
      end

      describe 'Disjunction (|)' do
        let(:schema) do
          Dry::Validation.Schema do
            required(:age) { none? | int? }
          end
        end

        it 'has correct types' do
          expect(fields.first[:types]).to eq([:none?, :int?])
        end
        it 'has correct logic' do
          expect(fields.first[:logic]).to eq([:or, [:none?], [:int?]])
        end
      end

      describe 'Implication (>)' do
        let(:schema) do
          Dry::Validation.Schema do
            required(:age) { filled? > str? }
          end
        end

        it 'has correct types' do
          expect(fields.first[:types]).to eq([:str?])
        end
        it 'has correct logic' do
          expect(fields.first[:logic]).to eq([:if, [:filled?], [:str?]])
        end
      end

      describe 'Exclusive Disjunction ^' do
        let(:schema) do
          Dry::Validation.Schema do
            required(:age) { lt?(10) ^ gt?(90) }
          end
        end

        it 'has correct types' do
          expect(fields.first[:types]).to eq([:int?])
        end
        it 'has correct logic' do
          expect(fields.first[:logic]).to eq([:xor, [:lt?, 10], [:gt?, 90]])
        end
      end

      describe 'Not' do
        let(:schema) do
          Dry::Validation.Schema do
            required(:admin) { true? | true?.not }
          end
        end

        it 'has correct types' do
          expect(fields.first[:types]).to eq([])
        end
        it 'has correct logic' do
          expect(fields.first[:logic]).to eq([:or, [:true?], :not, [:true?]])
        end
      end
    end
  end
end
