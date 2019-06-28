
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "libxml_extensions/version"

Gem::Specification.new do |spec|
  spec.name          = "libxml_extensions"
  spec.version       = LibxmlExtensions::VERSION
  spec.authors       = ["portal-team"]
  spec.email         = ["sosohan@cisco.com"]

  spec.summary       = %q{Provides methods to add arrays and hashes to LibXML::Node}
  spec.description   = %q{Allows shortcut APIs for LibXML Node to add arrays and hashes}
  spec.homepage      = "https://code.engine.sourcefire.com/Cloud/libxml_extensions"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://nexus.engine.sourcefire.com/repository/gems"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://code.engine.sourcefire.com/Cloud/libxml_extensions"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]


  spec.add_dependency 'libxml-ruby', '2.8.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
end