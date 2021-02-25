module AsdfDiscover::Config
  RSpec.describe Writer, :filesystem do
    around(:each) do |example|
      in_directory do
        example.run
      end
    end

    let(:writer) { Writer.new(".tool-versions") }

    it "writes tool versions" do
      tool_versions = [
        OpenStruct.new(tool: "ruby", version: "2.6.6", source: "Gemfile!"),
        OpenStruct.new(tool: "elixir", version: "1.10.0", source: "mix.exs")
      ]

      writer.write(tool_versions)

      written = File.read(".tool-versions")
      expect(written).to include("ruby 2.6.6 # from Gemfile!")
      expect(written).to include("elixir 1.10.0 # from mix.exs")
    end
  end
end
