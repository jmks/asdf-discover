module AsdfDiscover::Commands
  class Update < Command
    def run(context)
      @context = context

      read_existing_config
      search_for_tool_versions
      plan_update_of_tool_versions
      update_config
    end

    private

    def read_existing_config
      @existing_config = AsdfDiscover::Config::Reader.read(config_path)
    end

    def search_for_tool_versions
      @search_result ||= AsdfDiscover.search
    end

    def plan_update_of_tool_versions
      @plan = {}

      search = @search_result.tool_versions.map { |res| [res.tool, res] }.to_h

      @existing_config.each do |entry|
        found = search[entry.tool]
        
        next unless found

        @plan[entry.tool] = found
      end
    end

    def update_config
      if @plan.empty?
        @results << Warning.new(messages: ["No updates found"])
      else
        new_config = @existing_config.map do |entry|
          found = @plan[entry.tool]

          if newer?(entry, found)
            @results << Warning.new(
              messages: ["Updated #{entry.tool} to #{found.version} (was #{entry.version})"]
            )

            found
          else
            @results << Warning.new(
              messages: ["Detected #{entry.tool} #{found.version} but keeping specified #{entry.version}"]
            )

            entry
          end
        end

        AsdfDiscover::Config::Writer.new(config_path).write(new_config)
      end
    end

    def newer?(current, found)
      Gem::Version.new(found.version) > Gem::Version.new(current.version)
    end

    def config_path
      @_config_path ||= Pathname.new(@context.path).join(AsdfDiscover::TOOL_VERSIONS)
    end
  end
end
