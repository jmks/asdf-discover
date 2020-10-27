module AsdfDiscover
  module Searchers
    # Searches for a Ruby version in a Gemfile
    class Gemfile
      GEMFILE = "Gemfile".freeze

      def call
        return NotFound unless File.exist?(GEMFILE)

        File.open(GEMFILE, "r").each_line do |line|
          return Found.new("ruby", Regexp.last_match(1), GEMFILE) if line =~ /ruby ['"]([0-9.]+)['"]$/
        end

        NotFound
      end
    end
  end
end
