# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rhino_spec/version'

Gem::Specification.new do |spec|
  spec.name          = "rhino_spec"
  spec.version       = RhinoSpec::VERSION
  spec.authors       = ["Alex Riedler"]
  spec.email         = ["ariedler@codified.co"]
  spec.summary       = %q{A Distributed RSpec Server/Client workers.}
  spec.description   = %q{A way to parallelize the your tests to the end of time}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
