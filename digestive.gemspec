# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'digestive/version'

Gem::Specification.new do |spec|
  spec.name          = 'digestive'
  spec.version       = Digestive::VERSION
  spec.authors       = ['Robert Dallas Gray']
  spec.email         = ['mail@robertdallasgray.com']
  spec.description   = %q{Simple digest auth with roles}
  spec.summary       = %q{Simple digest auth with roles}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(/^spec\//)
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'm', '~> 1.3.1'
  spec.add_development_dependency 'guard', '>= 1.8'
  spec.add_development_dependency 'guard-minitest'
  spec.add_development_dependency 'activerecord', '~> 3'
  spec.add_development_dependency 'sqlite3'
end
