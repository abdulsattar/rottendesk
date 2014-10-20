# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rottendesk/version'

Gem::Specification.new do |spec|
  spec.name          = "rottendesk"
  spec.version       = Rottendesk::VERSION
  spec.authors       = ["Abdulsattar Mohammed"]
  spec.email         = ["asattar.md@gmail.com"]
  spec.summary       = %q{Ruby client for Freshdesk}
  spec.description   = %q{Ruby client for Freshdesk that uses the JSON API of Freshdesk}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'rest_client'

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
end
