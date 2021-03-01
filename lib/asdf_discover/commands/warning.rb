module AsdfDiscover
  module Commands
    class Warning
      attr_reader :messages, :status

      def initialize(messages:)
        @messages = messages
        @status = status
      end

      def error?; false; end
      def warning?; true; end
    end
  end
end