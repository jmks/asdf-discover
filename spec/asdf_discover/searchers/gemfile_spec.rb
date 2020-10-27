RSpec.describe AsdfDiscover::Searchers::Gemfile, :searcher do
  context "with a Gemfile" do
    context "when it has a ruby method call" do
      it "discovers the version" do
        in_directory do
          with_file "Gemfile", <<~GEMFILE
            source "https://rubygems.org"

            gemspec

            ruby "2.5"
          GEMFILE

          result = described_class.new.call

          expect(result).to be_found
          expect(result.language).to eq("ruby")
          expect(result.source).to eq("Gemfile")
        end
      end
    end

    context "when it does not have a ruby method call" do
      it "discovers nothing" do
        in_directory do
          with_file "Gemfile", %(gem "asdf-discover")

          expect(described_class.new.call).not_to be_found
        end
      end
    end
  end

  context "without a Gemfile" do
    it "discovers nothing" do
      result = described_class.new.call

      expect(result).not_to be_found
    end
  end
end
