module Dry
  module Types
    include Dry::Types.module

    module TestClasses
      class Simple < Struct
        attribute :name, Types::Strict::String
      end

      class Optional < Struct
        attribute :name, Types::Strict::String.optional
      end

      class MultipleTypes < Struct
        attribute :date_posted, Types::DateTime.optional |
                                Types::Strict::String.optional
      end

      class NestedStruct < Struct
        attribute :nested_name, Simple
      end
    end

    RSpec.describe Dry::Struct do
      describe Dry::Metadata::Fields do
        let(:field_attributes) { Dry::Metadata::Fields.from_struct(struct) }
        let(:fields) { field_attributes.fields }

        describe 'Simle Strict String' do
          let(:struct) do
            TestClasses::Simple
          end

          it 'has correct types' do
            expect(fields.first[:types]).to eq([:str?])
          end

          it 'has correct logic' do
            expect(fields.first[:logic]).to eq([[:str?]])
          end
        end

        describe 'Optional String' do
          let(:struct) do
            TestClasses::Optional
          end

          it 'has correct types' do
            expect(fields.first[:types]).to eq([:none?, :str?])
          end

          it 'has correct logic' do
            expect(fields.first[:logic]).to eq([:or, [:none?], [:str?]])
          end
        end

        describe 'MultipleTypes' do
          let(:struct) do
            TestClasses::MultipleTypes
          end

          it 'has correct types' do
            expect(fields.first[:types]).to eq([:none?, :date_time?, :str?])
          end

          it 'has correct logic' do
            expect(fields.first[:logic]).to eq([:or,
                                                :or, [:none?], [:date_time?],
                                                :or, [:none?], [:str?]])
          end
        end

        describe 'NestedStruct' do
          let(:struct) do
            TestClasses::NestedStruct
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
  end
end
