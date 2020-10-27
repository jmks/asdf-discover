module AsdfDiscover
  # The result of a search by a Searcher.
  # A result is either Found or NotFound.

  # A result that was found.
  Found = Struct.new(:language, :version, :source) do
    def found?
      true
    end
  end

  # A nil result
  class NotFound
    def self.found?
      false
    end
  end
end
