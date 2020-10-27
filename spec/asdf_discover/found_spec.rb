RSpec.describe AsdfDiscover::Found do
  context "when a result is found" do
    let(:result) { described_class.new("lang", "1.0", ".lang-version") }

    it { expect(result).to be_found }
    it { expect(result.language).to eq("lang") }
    it { expect(result.version).to eq("1.0") }
    it { expect(result.source).to eq(".lang-version") }
  end
end
