require "open3"

RSpec.describe "Executeable", :searcher do
  let!(:exe_path) { File.expand_path("exe/asdf-discover") }

  context "when a .tool-versions file exists" do
    it "exits with an error" do
      in_directory do
        with_file ".tool-versions", ""

        stdout, status = Open3.capture2(exe_path)

        expect(status).not_to be_success
        expect(stdout).to include(".tool-versions already exists!")
      end
    end
  end

  context "when no results are found" do
    it "displays no results found" do
      in_directory do
        stdout, status = Open3.capture2(exe_path)

        expect(status).not_to be_success
        expect(stdout).to include("No tool versions found!")
      end
    end
  end

  context "when there are conflicts" do
    it "prints conflicts" do
      in_directory do
        with_file "Gemfile", "ruby '2.6.6'"
        with_file ".ruby-version", "2.6.5"

        stdout, status = Open3.capture2(exe_path)

        expect(status).to be_success
        expect(stdout).to include(
          "Discovered multiple versions for ruby",
          "2.6.6 from Gemfile",
          "2.6.5 from .ruby-version"
        )
      end
    end
  end

  context "when tool versions are found" do
    it "writes a .tool-versions" do
      in_directory do
        with_file ".ruby-version", "2.7.2"

        stdout, status = Open3.capture2(exe_path)

        expect(status).to be_success
        expect(stdout).to be_empty
        expect(File.exist?(".tool-versions")).to be(true)
        expect(File.read(".tool-versions")).to include("ruby 2.7.2 # from .ruby-version")
      end
    end
  end
end
