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
  end
end