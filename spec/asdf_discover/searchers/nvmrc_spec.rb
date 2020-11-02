RSpec.describe AsdfDiscover::Searchers::Nvmrc, :filesystem do
  context "with a .nvmrc file" do
    it "discovers the version" do
      in_directory do
        with_file(".nvmrc", "14.16")

        result = described_class.new.call

        expect(result).to be_found
        expect(result.tool).to eq("nodejs")
        expect(result.version).to eq("14.16")
        expect(result.source).to eq(".nvmrc")
      end
    end
  end

  context "without a .nvmrc file" do
    it "discovers nothing" do
      in_directory do
        result = described_class.new.call

        expect(result).not_to be_found
      end
    end
  end
end
