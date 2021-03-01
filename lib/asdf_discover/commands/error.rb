module AsdfDiscover
  module Commands
    class Error
      attr_reader :messages, :status

      def initialize(messages:, status:)
        @messages = messages
        @status = status
      end

      def error?; true; end
      def warning?; false; end
    end
  end
end