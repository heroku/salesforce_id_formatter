# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'salesforce_id_formatter/version'

Gem::Specification.new do |spec|
  spec.name          = "salesforce_id_formatter"
  spec.version       = SalesforceIdFormatter::VERSION
  spec.authors       = ["Raul Murciano"]
  spec.email         = ["raul@heroku.com"]

  spec.summary       = %q{Formats Salesforce IDs}
  spec.description   = %q{}
  spec.homepage      = "https://github.com/heroku/salesforce_id_formatter"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.7"
end
