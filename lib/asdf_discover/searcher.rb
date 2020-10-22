module AsdfDiscover
  # A Searcher responds to #call and returns a AsdfDiscover::Result
  class Searcher
    # call should return either Found or NotFound
    def call
      raise "implement me"
    end
  end
end
