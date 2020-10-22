module AsdfDiscover
  # The Result of a search by a Searcher.
  # A Result is either Found or NotFound.

  # A Result that was found.
  # Has fields: language, version, and source
  Found = Struct.new(:language, :version, :source) do
    def found?
      true
    end
  end

  # A nil Result
  class NotFound
    def self.found?
      false
    end
  end
end
