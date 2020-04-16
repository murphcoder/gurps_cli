
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "gurps_cli/version"

Gem::Specification.new do |spec|
  spec.name          = "gurps_cli"
  spec.version       = GurpsCli::VERSION
  spec.authors       = ["'Sean Murphy'"]
  spec.email         = ["'murphcoder@gmail.com'"]

  spec.summary       = "Creates a text based interface for looking at GURPS books."
  spec.description   = "Allows the user to look at sourcebooks for the roleplaying game GURPS in a text based interface, allowing them to look at books individually, or buy the categories of topic ans series."
  spec.homepage      = "https://github.com/murphcoder/gurps_cli"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
end
