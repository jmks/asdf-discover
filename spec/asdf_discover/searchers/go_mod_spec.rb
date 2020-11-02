RSpec.describe AsdfDiscover::Searchers::GoMod, :filesystem do
  context "with a go.mod" do
    it "discovers the version" do
      in_directory do
        with_file "go.mod", "go 1.15"

        result = described_class.new.call

        expect(result).to be_found
        expect(result.tool).to eq("golang")
        expect(result.version).to eq("1.15")
        expect(result.source).to eq("go.mod")
      end
    end
  end

  context "without a go.mod" do
    it "discovers nothing" do
      result = described_class.new.call

      expect(result).not_to be_found
    end
  end
end
