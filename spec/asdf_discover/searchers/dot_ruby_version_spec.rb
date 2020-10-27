require "spec_helper"

RSpec.describe AsdfDiscover::Searchers::DotRubyVersion, :searcher do
  context "with a .ruby-version file" do
    it "discovers the version" do
      in_directory do
        with_file(".ruby-version", "2.6.6")

        result = described_class.new.call

        expect(result).to be_found
        expect(result.version).to eq("2.6.6")
        expect(result.source).to eq(".ruby-version")
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
