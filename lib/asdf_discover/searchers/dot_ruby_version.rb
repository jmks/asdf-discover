module AsdfDiscover
  module Searchers
    class DotRubyVersion
      RUBY_VERSION_FILE = ".ruby-version"

      def call
        return NotFound unless File.exist?(RUBY_VERSION_FILE)

        version = File.read(RUBY_VERSION_FILE).chomp

        Found.new("ruby", version, RUBY_VERSION_FILE)
      end
    end
  end
end
