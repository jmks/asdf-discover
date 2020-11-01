module AsdfDiscover
  # Amalgamated results from Searchers.
  # Contains the data required to display warnings and write the .tool-versions file.
  class SearchResult
    Conflict = Struct.new(:tool, :sources)

    def initialize(results)
      @results = results
    end

    def consistent?
      conflicts.none?
    end

    def conflicts
      @conflicts ||= find_conflicts
    end

    def tool_versions
      @tool_versions ||= collect_tool_versions
    end

    def any?
      @results.any?
    end

    private

    def find_conflicts
      @results
        .group_by(&:tool)
        .filter { |_tool, matches| matches.map(&:version).uniq.length != 1 }
        .map { |tool, matches| Conflict.new(tool, matches) }
    end

    def collect_tool_versions
      @results
        .sort_by { |e| [e.tool, e.version] }
        .uniq { |e| [e.tool, e.version] }
    end
  end
end
