module AsdfDiscover
  module Searchers
    # Searches in .node-version
    class DotNodeVersion
      NODE_VERSION = ".node-version".freeze

      def call
        return NotFound unless File.exist?(NODE_VERSION)

        version = File.read(NODE_VERSION).chomp

        Found.new("nodejs", version, NODE_VERSION)
      end
    end
  end
end
