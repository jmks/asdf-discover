require "ostruct"

RSpec.describe AsdfDiscover::SearchResult do
  describe "#consistent?" do
    context "when all versions are the same for a language" do
      it "is consistent" do
        result = described_class.new([
          AsdfDiscover::Found.new("lang", "1.0", ".lang-version"),
          AsdfDiscover::Found.new("lang", "1.0", "langfile"),
        ])

        expect(result).to be_consistent
      end
    end

    context "when there are multiple versions discovered for a language" do
      it "is inconsistent" do
        result = described_class.new([
          AsdfDiscover::Found.new("lang", "1.1", ".lang-version"),
          AsdfDiscover::Found.new("lang", "1.2", "langfile"),
        ])

        expect(result).not_to be_consistent
      end
    end
  end

  describe "#conflicts" do
    let(:result) do
      described_class.new([
        AsdfDiscover::Found.new("lang", "1.1", ".lang-version"),
        AsdfDiscover::Found.new("lang", "1.2", "langfile"),
      ])
    end
    let(:conflict) { result.conflicts.first }

    it "is a collection" do
      expect(result.conflicts).to respond_to(:each)
    end

    describe "each" do
      it "have a language" do
        expect(conflict.language).to eq("lang")
      end

      it "have sources" do
        expect(conflict.sources).to respond_to(:each)

        expect(conflict.sources[0]).to have_attributes(version: "1.1", source: ".lang-version")
        expect(conflict.sources[1]).to have_attributes(version: "1.2", source: "langfile")
      end
    end
  end

  describe "#tool_versions" do
    it "is in alphabetical order by tool" do
      result = described_class.new([
        OpenStruct.new(tool: "bananas"),
        OpenStruct.new(tool: "oranges"),
        OpenStruct.new(tool: "apples"),
      ])

      expect(result.tool_versions.map(&:tool)).to eq(["apples", "bananas", "oranges"])
    end

    it "includes multiple conflicts, subordered by version" do
      result = described_class.new([
        OpenStruct.new(tool: "oranges", version: "rc1"),
        OpenStruct.new(tool: "oranges", version: "rc1"),
        OpenStruct.new(tool: "apples", version: "1.1"),
        OpenStruct.new(tool: "apples", version: "1.0"),
      ])

      expect(result.tool_versions.length).to eq(3)
      expect(result.tool_versions[0]).to have_attributes(tool: "apples", version: "1.0")
      expect(result.tool_versions[1]).to have_attributes(tool: "apples", version: "1.1")
      expect(result.tool_versions[2]).to have_attributes(tool: "oranges", version: "rc1")
    end
  end
end
