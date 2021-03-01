module AsdfDiscover
  module Commands
    class Search < Command
      def run(context)
        @context = context

        ensure_config_exists
        verify_results
        write_config
      end

      private

      def ensure_config_exists
        if File.exist?(config_path)
          @results << Error.new(messages: ["#{config_path} already exists!"], status: 1)
        end
      end

      def verify_results
        ensure_results_found
        ensure_results_are_consistent
      end

      def ensure_results_found
        return if search_result.any?

        @results << Error.new(messages: ["No tool versions found!"], status: 1)
      end

      def ensure_results_are_consistent
        return if search_result.consistent?

        lines = []

        search_result.conflicts.each do |conflict|
          lines << "Discovered multiple versions for #{conflict.tool}:"
          conflict.sources.each do |source|
            lines << "  - #{source.version} from #{source.source}"
          end
          lines << ""
        end

        lines << "You should manually reconcile which version to use"
        lines << ".tool-versions will include all versions discovered"
        lines << "asdf, by default, will use the first entry"

        @results << Warning.new(messages: lines)
      end

      def write_config
        return if errors?

        AsdfDiscover::Config::Writer.new(config_path).write(search_result.tool_versions)
      end

      def search_result
        @_search_result ||= AsdfDiscover.search
      end

      def config_path
        @_config_path ||= Pathname.new(@context.path).join(AsdfDiscover::TOOL_VERSIONS)
      end
    end
  end
end