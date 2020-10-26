require "asdf_discover/result"
require "asdf_discover/searchers/dot_ruby_version"
require "asdf_discover/version"

module AsdfDiscover
  TOOL_VERSIONS = ".tool-versions"

  def self.add_searcher(*searchers)
    @searchers ||= []
    @searchers.concat(searchers)
  end

  def self.search
    @searchers
      .map(&:new)
      .map(&:call)
      .select(&:found?)
  end

  add_searcher Searchers::DotRubyVersion
end
