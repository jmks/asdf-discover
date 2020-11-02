require "asdf_discover/result"
require "asdf_discover/search_result"
require "asdf_discover/searchers/dot_node_version"
require "asdf_discover/searchers/dot_ruby_version"
require "asdf_discover/searchers/gemfile"
require "asdf_discover/searchers/go_mod"
require "asdf_discover/version"

# Namespace for the gem
module AsdfDiscover
  TOOL_VERSIONS = ".tool-versions".freeze

  def self.add_searcher(*searchers)
    @searchers ||= []
    @searchers.concat(searchers)
  end

  def self.search
    found = @searchers
      .map(&:new)
      .map(&:call)
      .select(&:found?)

    SearchResult.new(found)
  end

  add_searcher Searchers::DotNodeVersion
  add_searcher Searchers::DotRubyVersion
  add_searcher Searchers::Gemfile
  add_searcher Searchers::GoMod
end
