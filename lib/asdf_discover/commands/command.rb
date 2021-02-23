module AsdfDiscover::Commands
  class Command
    def initialize
      @results = []
    end

    def add(result)
      @results << result
    end

    def errors?
      @results.any?(&:error?)
    end
  end
end