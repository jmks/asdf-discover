module AsdfDiscover::Commands
  RSpec.describe Search, :filesystem do
    around(:each) do |example|
      in_directory do
        example.run
      end
    end

    let(:context) { OpenStruct.new(path: Dir.pwd) }
    let(:cmd) { Search.new }

    context "when no tool versions are found" do
      it "exits with an error" do
        cmd.run(context)

        expect(cmd.errors?).to be(true)
        expect(output(cmd)).to include("No tool versions found!")
        expect(exit_status(cmd)).to be(1)
      end
    end

    context "when a .tool-versions file exists" do
      it "exits with an error" do
        with_file ".tool-versions", ""

        cmd.run(context)

        expect(cmd.errors?).to be(true)
        expect(output(cmd)).to include("already exists!")
        expect(exit_status(cmd)).to be(1)
      end
    end

    context "when there are tool version conflicts" do
      it "prints the conflicts" do
        with_file "Gemfile", "ruby '2.6.6'"
        with_file ".ruby-version", "2.6.5"

        cmd.run(context)

        expect(cmd.errors?).to be(false)
        expect(cmd.warnings?).to be(true)
        expect(output(cmd)).to include(
          "Discovered multiple versions for ruby",
          "2.6.6 from Gemfile",
          "2.6.5 from .ruby-version"
        )
      end
    end

    context "when tool versions are found" do
      it "writes a .tool-versions" do
        with_file ".ruby-version", "2.7.2"

        cmd.run(context)

        expect(cmd.errors?).to be(false)
        expect(cmd.warnings?).to be(false)
        expect(File.exist?(".tool-versions")).to be(true)
        expect(File.read(".tool-versions")).to include("ruby 2.7.2 # from .ruby-version")
      end
    end

    def output(command)
      command.results.map(&:messages).join("\n")
    end

    def exit_status(command)
      command.results.select(&:error?).map(&:status).first
    end
  end
end