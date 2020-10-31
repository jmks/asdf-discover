module AsdfDiscover
  # The result of a search by a Searcher.
  # A result is either Found or NotFound.

  # A result that was found.
  Found = Struct.new(:tool, :version, :source) do
    def found?
      true
    end

    # TODO: update usages of this
    def language
      tool
    end
  end

  # A nil result
  class NotFound
    def self.found?
      false
    end
  end
end
