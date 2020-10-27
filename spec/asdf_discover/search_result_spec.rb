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
end
