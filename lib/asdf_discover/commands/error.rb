module AsdfDiscover::Commands
  class Error
    def initialize(messages:, status:)
      @messages = messages
      @status = status
    end

    def error?; true; end
    def warning?; false; end
  end
end