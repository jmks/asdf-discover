require_relative "lib/asdf_discover/version"

Gem::Specification.new do |spec|
  spec.name          = "asdf-discover"
  spec.version       = AsdfDiscover::VERSION
  spec.authors       = ["Jason Schweier"]
  spec.email         = ["jason.schweier@gmail.com"]

  spec.summary       = %(Simple command to discover what should be in ASDF's .tool-versions file)
  spec.homepage      = "https://github.com/jmks/asdf-discover"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.6.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/jmks/asdf-discover"
  # spec.metadata["changelog_uri"] = "https://github.com/jmks/asdf-discover/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rubocop", "~> 1.0"
  spec.add_development_dependency "rubocop-rspec", "~> 1.0"
end
