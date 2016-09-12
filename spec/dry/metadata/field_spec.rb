RSpec.describe Dry::Metadata::Fields do
  let(:field) do
    Dry::Metadata::Field.new(name: :myname,
                             required: true,
                             types: [], logic: [])
  end

  describe 'to_s' do
    it 'returns a well formatted string' do
      expect(field.to_s).to eq('<name: myname, required: true, ' \
                               'types: [], logic: [], fields: []>')
    end
  end
end
