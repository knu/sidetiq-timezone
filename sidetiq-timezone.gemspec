# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sidetiq-timezone/version'

Gem::Specification.new do |spec|
  spec.name          = "sidetiq-timezone"
  spec.version       = SidetiqTimezone::VERSION
  spec.authors       = ["Akinori MUSHA"]
  spec.email         = ["knu@idaemons.org"]

  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  # end

  spec.summary       = %q{Time zone support for Sidetiq}
  spec.description   = <<'EOF'
This library adds time zone support to Sidetiq.

You can name a time zone for Sidetiq to use or just let it honor the
value of `Time.zone`.
EOF
  spec.homepage      = "https://github.com/knu/sidetiq-timezone"
  spec.license       = "2-clause BSDL"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "sidetiq", "~> 0.6"
  spec.add_runtime_dependency "activesupport", ">= 0"

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", ">= 10.0"
  spec.add_development_dependency "rspec"
end
