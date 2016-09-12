RSpec.describe Dry::Validation do
  describe Dry::Metadata::Fields do
    describe 'Built-in Predicates' do
      let(:fields) { Dry::Metadata::Fields.from_validation(schema) }

      describe 'not_eql?' do
        let(:schema) do
          Dry::Validation.Schema do
            required(:foo) { not_eql?(23) }
          end
        end

        it 'has correct types' do
          expect(fields.first[:types]).to eq([:int?])
        end

        it 'has correct logic' do
          expect(fields.first[:logic]).to eq([[:not_eql?, 23]])
        end
      end

      describe 'odd?' do
        let(:schema) do
          Dry::Validation.Schema do
            required(:foo) { odd? }
          end
        end

        it 'has correct types' do
          expect(fields.first[:types]).to eq([:int?])
        end

        it 'has correct logic' do
          expect(fields.first[:logic]).to eq([[:odd?]])
        end
      end

      describe 'even?' do
        let(:schema) do
          Dry::Validation.Schema do
            required(:foo) { even? }
          end
        end

        it 'has correct types' do
          expect(fields.first[:types]).to eq([:int?])
        end

        it 'has correct logic' do
          expect(fields.first[:logic]).to eq([[:even?]])
        end
      end

      describe 'includes?' do
        let(:schema) do
          Dry::Validation.Schema do
            required(:foo) { includes?([1, 2, 3]) }
          end
        end

        it 'has correct types' do
          expect(fields.first[:types]).to eq([:int?])
        end

        it 'has correct logic' do
          expect(fields.first[:logic]).to eq([[:includes?, [1, 2, 3]]])
        end
      end

      describe 'excludes?' do
        let(:schema) do
          Dry::Validation.Schema do
            required(:foo) { excludes?(1) }
          end
        end

        it 'has correct types' do
          expect(fields.first[:types]).to eq([:int?])
        end

        it 'has correct logic' do
          expect(fields.first[:logic]).to eq([[:excludes?, 1]])
        end
      end

      describe 'none?' do
        let(:schema) do
          Dry::Validation.Schema do
            required(:sample).value(:none?)
          end
        end

        it 'has correct types' do
          expect(fields.first[:types]).to eq([:none?])
        end

        it 'has correct logic' do
          expect(fields.first[:logic]).to eq([[:none?]])
        end
      end

      TYPES = { none?: nil,
                bool?: true,
                str?: '123',
                int?: 123,
                float?: 1.23,
                decimal?: BigDecimal.new('1.23'),
                date?: Date.new(2016, 12, 31),
                date_time?: DateTime.new(2016, 12, 31),
                time?: Time.new(2016, 12, 31),
                # hash: {a: :b},
                array?: [1, 2, 3] }.freeze

      TYPES.each do |key, value|
        describe "eql? #{key}" do
          let(:schema) do
            Dry::Validation.Schema do
              required(:sample).value(eql?: value)
            end
          end

          it 'has correct types' do
            expect(fields.first[:types]).to eq([key])
          end
          it 'has correct logic' do
            expect(fields.first[:logic]).to eq([[:eql?, value]])
          end
        end

        describe "type? #{key}" do
          let(:schema) do
            Dry::Validation.Schema do
              required(:sample).value(type?: value.class)
            end
          end

          it 'has correct types' do
            expect(fields.first[:types]).to eq([key])
          end

          it 'has correct logic' do
            expect(fields.first[:logic]).to eq([[key]])
          end
        end
      end

      describe 'empty?' do
        let(:schema) do
          Dry::Validation.Schema do
            required(:sample).value(:empty?)
          end
        end

        it 'has correct types' do
          expect(fields.first[:types]).to eq([])
        end
        it 'has correct logic' do
          expect(fields.first[:logic]).to eq([[:empty?]])
        end
      end

      describe 'filled?' do
        let(:schema) do
          Dry::Validation.Schema do
            required(:sample).value(:filled?)
          end
        end

        it 'has correct types' do
          expect(fields.first[:types]).to eq([])
        end

        it 'has correct logic' do
          expect(fields.first[:logic]).to eq([[:filled?]])
        end
      end

      NUMERIC_COMPARITORS = [:gt?, :gteq?, :lt?, :lteq?].freeze

      NUMERIC_COMPARITORS.each do |comparitor|
        TYPES.each do |type, value|
          describe "#{comparitor} #{type}:#{value}" do
            let(:schema) do
              Dry::Validation.Schema do
                required(:sample).value(comparitor => value)
              end
            end

            it 'has correct types' do
              expect(fields.first[:types]).to eq([type])
            end

            it 'has correct logic' do
              expect(fields.first[:logic]).to eq([[comparitor, value]])
            end
          end
        end
      end

      ARRAY_COMPARITORS = [:max_size?, :min_size?, :size?].freeze
      ARRAY_COMPARITORS.each do |comparitor|
        TYPES.each do |type, value|
          describe "#{comparitor} #{type}:#{value}" do
            let(:schema) do
              Dry::Validation.Schema do
                required(:sample).value(comparitor => value)
              end
            end

            it 'has correct types' do
              expect(fields.first[:types]).to eq([])
            end

            it 'has correct logic' do
              expect(fields.first[:logic]).to eq([[comparitor, value]])
            end
          end
        end
      end

      describe 'format?' do
        let(:schema) do
          Dry::Validation.Schema do
            required(:sample).value(format?: /^a/)
          end
        end

        it 'has correct types' do
          expect(fields.first[:types]).to eq([:str?])
        end
        it 'has correct logic' do
          expect(fields.first[:logic]).to eq([[:format?, /^a/]])
        end
      end

      %i(excluded_from? included_in?).each do |predicate|
        describe predicate do
          let(:schema) do
            Dry::Validation.Schema do
              required(:sample).value(predicate => [1, 3, 5])
            end
          end

          it 'has correct types' do
            expect(fields.first[:types]).to eq([:int?])
          end
          it 'has correct logic' do
            expect(fields.first[:logic]).to eq([[predicate, [1, 3, 5]]])
          end
        end
      end
    end
  end
end
