module AsdfDiscover::Config
  RSpec.describe Reader, :filesystem do
    around(:each) do |example|
      in_directory do
        example.run
      end
    end

    it "reads tool entries" do
      with_file ".tool-versions", <<~TOOLS
        ruby 2.7.2
        elixir 1.10
      TOOLS

      expect(Reader.read(".tool-versions")).to contain_exactly(
        have_attributes(tool: "ruby", version: "2.7.2"),
        have_attributes(tool: "elixir", version: "1.10")
      )
    end

    it "reads comments" do
      with_file ".tool-versions", <<~TOOLS
        # just a comment
             
        ruby 2.7.2 # ruby with a comment
      TOOLS

      expect(Reader.read(".tool-versions")).to contain_exactly(
        have_attributes(comment: "just a comment", tool: nil, version: nil),
        have_attributes(comment: "ruby with a comment", tool: "ruby", version: "2.7.2")
      )
    end
  end
end