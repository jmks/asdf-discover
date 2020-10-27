module AsdfDiscover
  module Searchers
    class Gemfile
      GEMFILE = "Gemfile"

      def call
        return NotFound unless File.exist?(GEMFILE)

        File.open(GEMFILE, "r").each_line do |line|
          if line =~ /ruby ['"]([0-9.]+)['"]$/
            return Found.new("ruby", Regexp.last_match(1), GEMFILE)
          end
        end

        NotFound
      end
    end
  end
end
