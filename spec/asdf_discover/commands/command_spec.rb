module AsdfDiscover::Commands
  RSpec.describe Command do
    describe ".errors?" do
      it "is false when results do not have an error" do
        command = Command.new
        command.add(OpenStruct.new(error?: false))

        expect(command.errors?).to be(false)
      end

      it "is true when results contains a error" do
        command = Command.new
        command.add(OpenStruct.new(error?: true))

        expect(command.errors?).to be(true)
      end
    end

    describe ".warnings?" do
      it "is false when results do not have a warning" do
        command = Command.new
        command.add(OpenStruct.new(warning?: false))

        expect(command.warnings?).to be(false)
      end

      it "is true when results contains a error" do
        command = Command.new
        command.add(OpenStruct.new(warning?: true))

        expect(command.warnings?).to be(true)
      end
    end
  end
end