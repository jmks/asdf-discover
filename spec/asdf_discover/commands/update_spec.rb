module AsdfDiscover::Commands
  RSpec.describe Update, :filesystem, :commands do
    around(:each) do |example|
      in_directory do
        example.run
      end
    end

    let(:context) { OpenStruct.new(path: Dir.pwd) }
    let(:cmd) { Update.new }

    describe "updating a .tool-versions" do
      it "updates to newer version" do
        with_file ".tool-versions", "ruby 2.6.6"
        with_file ".ruby-version", "2.7.2"

        cmd.run(context)

        expect(cmd.errors?).to be(false)
        expect(output(cmd)).to include("Updated ruby to 2.7.2 (was 2.6.6)")
        expect(File.read(".tool-versions")).to include("ruby 2.7.2")
      end

      it "does not downgrade a vesion" do
        with_file ".tool-versions", "ruby 2.7.2"
        with_file ".ruby-version", "2.6.6"

        cmd.run(context)

        expect(cmd.errors?).to be(false)
        expect(output(cmd)).to include("Detected ruby 2.6.6 but keeping specified 2.7.2")
        expect(File.read(".tool-versions")).to include("ruby 2.7.2")
      end
    end

    describe "updating the global .tool-versions" do
      it "updates .tool-versions from asdf"
      # with_tool_versions "ruby" => "2.7.2"
    end
  end
end
