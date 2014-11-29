# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'itamae/plugin/recipe/openresty/version'

Gem::Specification.new do |spec|
  spec.name          = "itamae-plugin-recipe-openresty"
  spec.version       = Itamae::Plugin::Recipe::Openresty::VERSION
  spec.authors       = ["Takatoshi Maeda"]
  spec.email         = ["me@tmd.tw"]
  spec.summary       = %q{Itamae openresty recipe plugin}
  spec.description   = %q{Itamae openresty recipe plugin}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
