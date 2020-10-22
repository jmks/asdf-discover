RSpec.describe "A Result" do
  context "when a result is found" do
    subject { AsdfDiscover::Found.new("lang", "1.0", ".lang-version") }

    it { is_expected.to be_found }
    it { expect(subject.language).to eq("lang") }
    it { expect(subject.version).to eq("1.0") }
    it { expect(subject.source).to eq(".lang-version") }
  end

  context "when no result is found" do
    subject { AsdfDiscover::NotFound }

    it { is_expected.not_to be_found }
  end
end
