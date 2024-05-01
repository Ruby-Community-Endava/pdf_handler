# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__) # rubocop:disable Style/ExpandPathArguments
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |g|
  g.name = 'pdf_handler'
  g.version = '0.0.1'
  g.date = '2024-03-07'
  g.summary = 'PDF Handler PoC'
  g.description = 'PDF Handler PoC'
  g.license = 'MIT'
  g.authors = ['Johan Tique']
  g.email = 'johan.tique@endava.com'
  g.homepage = 'https://github.com/jtique-endava'
  g.files =
    Dir.chdir(File.expand_path(__dir__)) do
      `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
    end
  g.files += %w[README.md LICENSE]
  g.require_paths = %w[lib]
  g.required_ruby_version = '>= 2.7'

  g.add_development_dependency('pry')
end
