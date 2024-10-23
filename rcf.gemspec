require_relative "lib/rcf/version"

Gem::Specification.new do |spec|
  spec.name          = "rcf"
  spec.version       = Rcf::VERSION
  spec.summary       = "Random Cut Forest anomaly detection for Ruby"
  spec.homepage      = "https://github.com/ankane/random-cut-forest-ruby"
  spec.license       = "Apache-2.0"

  spec.author        = "Andrew Kane"
  spec.email         = "andrew@ankane.org"

  spec.files         = Dir["*.{md,txt}", "{lib,vendor}/**/*"]
  spec.require_path  = "lib"

  spec.required_ruby_version = ">= 3.1"

  spec.add_dependency "fiddle"
end
