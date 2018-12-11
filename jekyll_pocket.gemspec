lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jekyll_pocket/version'

Gem::Specification.new do |spec|
  spec.name          = 'jekyll_pocket'
  spec.version       = JekyllPocket::VERSION
  spec.authors       = ['Marii']
  spec.email         = ['m.nyrop@columbia.edu']

  spec.summary       = 'jekyll hook plugin for building a fully portable site'
  spec.homepage      = 'https://github.com/mnyrop/jekyll_pocket'
  spec.license       = 'MIT'

  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.6'
end
