require "fileutils"
require "tmpdir"

module FilesystemHelpers
  def in_directory
    pwd = FileUtils.pwd

    Dir.mktmpdir do |dir|
      FileUtils.cd(dir)

      yield

    ensure
      FileUtils.cd(pwd)
    end
  end

  def with_file(path, content)
    File.open(path, "w") { |f| f.write(content) }
  end
end
