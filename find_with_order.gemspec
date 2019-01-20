# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'find_with_order/version'

Gem::Specification.new do |spec|
  spec.name          = "find_with_order"
  spec.version       = FindWithOrder::VERSION
  spec.authors       = ["khiav reoy"]
  spec.email         = ["mrtmrt15xn@yahoo.com.tw"]

  spec.summary       = %q{A simple way to find records in the same order of input array.}
  spec.description   = %q{A simple way to find records in the same order of input array. Has better performance than manually sorting. Supports Rails 3+.}
  spec.homepage      = "https://github.com/khiav223577/find_with_order"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  #if spec.respond_to?(:metadata)
  #  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  #else
  #  raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  #end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '>= 1.17', '< 3.x'
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "mysql2", ">= 0.3"
  spec.add_development_dependency "pg", "~> 0.18"

  spec.add_dependency "activerecord", ">= 3"

end
