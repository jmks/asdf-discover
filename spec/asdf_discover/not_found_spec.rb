RSpec.describe AsdfDiscover::NotFound do
  context "when no result is found" do
    let(:result) { described_class }

    it { expect(result).not_to be_found }
  end
end
