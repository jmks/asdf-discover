RSpec.describe AsdfDiscover::Searchers::DotNodeVersion, :filesystem do
  context "with a .node-version file" do
    it "discovers the version" do
      in_directory do
        with_file(".node-version", "14.2")

        result = described_class.new.call

        expect(result).to be_found
        expect(result.version).to eq("14.2")
        expect(result.source).to eq(".node-version")
      end
    end
  end

  context "without a .ruby-version file" do
    it "discovers nothing" do
      in_directory do
        result = described_class.new.call

        expect(result).not_to be_found
      end
    end
  end
end
