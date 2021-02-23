module AsdfDiscover::Commands
  class Warning
    def initialize(messages:)
      @messages = messages
      @status = status
    end

    def error?; false; end
    def warning?; true; end
  end
end