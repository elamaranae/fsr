# frozen_string_literal: true

require_relative 'lib/fsr/version'

Gem::Specification.new do |spec|
  spec.name = 'fsr'
  spec.version = Fsr::VERSION
  spec.authors = ['Elamaran Angusamy Elango']
  spec.email = ['maran@maran.dev']

  spec.summary = 'Run RSpec fast by avoiding full app boot'
  spec.homepage = 'https://maran.dev'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.3.0'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/elamaranae/fsr'
  spec.metadata['changelog_uri'] = 'https://github.com/elamaranae/fsr/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'listen'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
