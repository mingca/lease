# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lease/version'

Gem::Specification.new do |spec|
  spec.name          = 'lease'
  spec.version       = Lease::VERSION
  spec.authors       = ['Ninja Rails']
  spec.email         = ['ninjarailsdev@gmail.com']

  spec.summary       = %q{Lease templates and envelopes}
  spec.homepage      = 'https://www.github.com/mingca/lease.git'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rails', '~> 5'
  spec.add_dependency 'carrierwave', '~> 1.0'
  spec.add_dependency 'wicked_pdf', '~> 1.1.0'
  spec.add_dependency 'wkhtmltopdf-binary', '~> 0.12.3.1'

  spec.add_development_dependency 'bundler', '~> 1.17.3'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.7'
  spec.add_development_dependency 'rspec-rails', '~> 3.7'
  spec.add_development_dependency 'factory_bot_rails', '~> 4.8'
  spec.add_development_dependency 'sqlite3', '~> 1'
end
