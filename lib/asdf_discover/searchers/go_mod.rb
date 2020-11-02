module AsdfDiscover
  module Searchers
    # Searches for a Go version in the go.mod file
    class GoMod
      GO_MOD = "go.mod".freeze

      def call
        return NotFound unless File.exist?(GO_MOD)

        File.open(GO_MOD, "r").each_line do |line|
          return Found.new("golang", Regexp.last_match(1), GO_MOD) if line =~ /go ([0-9.]+)$/
        end

        NotFound
      end
    end
  end
end
