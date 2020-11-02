module AsdfDiscover
  module Searchers
    # Searches in .nvmrc
    class Nvmrc
      NVMRC = ".nvmrc".freeze

      def call
        return NotFound unless File.exist?(NVMRC)

        version = File.read(NVMRC).chomp

        Found.new("nodejs", version, NVMRC)
      end
    end
  end
end
