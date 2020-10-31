module AsdfDiscover
  # Amalgamated results from Searchers.
  # Contains the data required to display warnings and write the .tool-versions file.
  class SearchResult
    Conflict = Struct.new(:language, :sources)

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

    private

    def find_conflicts
      @results
        .group_by(&:language)
        .filter { |_lang, matches| matches.map(&:version).uniq.length != 1 }
        .map { |lang, matches| Conflict.new(lang, matches) }
    end

    def collect_tool_versions
      @results
        .sort_by { |e| [e.tool, e.version] }
        .uniq { |e| [e.tool, e.version] }
    end
  end
end
