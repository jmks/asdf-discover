module AsdfDiscover::Config
  Entry = Struct.new(:tool, :version, :comment) do
    def comment?
      comment != nil && comment != ""
    end
  end

  class Reader
    def self.read(path)
      contents(path)
    end

    private

    def self.contents(path)
      File
        .read(path)
        .lines
        .map(&:chomp)
        .map(&:strip)
        .reject { |line| line.length.zero? }
        .map(&method(:parse_entry))
    end

    def self.parse_entry(line)
      if line.include?("#")
        entry, comment = line.split("#").map(&:strip)
        tool, version = entry.split(" ")

        Entry.new(tool, version, comment)
      else
        tool, version = line.split()

        Entry.new(tool, version, nil)
      end
    end
  end
end