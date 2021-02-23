module AsdfDiscover::Commands
  class Command
    attr_reader :results

    def initialize
      @results = []
    end

    def add(result)
      @results << result
    end

    def errors?
      @results.any?(&:error?)
    end

    def warnings?
      @results.any?(&:warning?)
    end
  end
end