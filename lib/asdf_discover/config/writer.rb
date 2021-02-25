module AsdfDiscover::Config
  class Writer
    def initialize(path)
      @filepath = path
    end

    def write(tool_versions)
      File.open(@filepath, "w") do |f|
        tool_versions.each do |tool_version|
          f.puts "#{tool_version.tool} #{tool_version.version} # from #{tool_version.source}"
        end
      end
    end
  end
end