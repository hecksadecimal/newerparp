# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bbcode-rails/version'

Gem::Specification.new do |spec|
  spec.name          = "bbcode-rails"
  spec.version       = BBCode::VERSION
  spec.authors       = ["Marcel Müller"]
  spec.email         = ["neikos@neikos.email"]

  spec.summary       = %q{A simple BBCode gem for Rails}
  spec.description   = %q{A simple and efficient way of managing BBCode in a rails application.}
  spec.homepage      = "https://github.com/TheNeikos/bbcode-rails"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
end
