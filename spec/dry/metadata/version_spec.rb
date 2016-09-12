RSpec.describe 'Dry::Metadata::VERSION' do
  let(:gemspec_path) { DryMetadataSpec::ROOT.join('dry-metadata.gemspec').to_s }

  it 'matches specification version' do
    specification = Gem::Specification.load(gemspec_path)

    expect(Dry::Metadata::VERSION).to eql(specification.version.to_s)
  end
end
