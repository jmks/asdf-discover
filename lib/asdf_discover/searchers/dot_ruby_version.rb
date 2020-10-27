module AsdfDiscover
  module Searchers
    # Searches in .ruby-version
    class DotRubyVersion
      RUBY_VERSION_FILE = ".ruby-version".freeze

      def call
        return NotFound unless File.exist?(RUBY_VERSION_FILE)

        version = File.read(RUBY_VERSION_FILE).chomp

        Found.new("ruby", version, RUBY_VERSION_FILE)
      end
    end
  end
end
