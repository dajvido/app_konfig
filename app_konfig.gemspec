# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'app_konfig/version'

Gem::Specification.new do |spec|
  spec.name          = "app_konfig"
  spec.version       = AppKonfig::VERSION
  spec.authors       = ["Bartosz Kopiński", "Radosław Piątek"]
  spec.email         = ["bartosz@kopinski.pl", "radek.nekath@gmail.com"]
  spec.summary       = "Lightweight app configuration for Rails"
  spec.homepage      = "https://github.com/netguru/app_konfig"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", ">= 3.0"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.3"
end
