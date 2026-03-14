# frozen_string_literal: true

require_relative 'lib/legion/extensions/cognitive_load_balancing/version'

Gem::Specification.new do |spec|
  spec.name    = 'lex-cognitive-load-balancing'
  spec.version = Legion::Extensions::CognitiveLoadBalancing::VERSION
  spec.authors = ['Esity']
  spec.email   = ['matthewdiverson@gmail.com']

  spec.summary     = 'Cognitive load balancing across subsystems for LegionIO'
  spec.description = 'Dynamic distribution of cognitive work across subsystems with ' \
                     'overload detection, auto-assignment, and rebalancing.'
  spec.homepage    = 'https://github.com/LegionIO/lex-cognitive-load-balancing'
  spec.license     = 'MIT'

  spec.required_ruby_version = '>= 3.4'

  spec.metadata['homepage_uri']      = spec.homepage
  spec.metadata['source_code_uri']   = 'https://github.com/LegionIO/lex-cognitive-load-balancing'
  spec.metadata['documentation_uri'] = 'https://github.com/LegionIO/lex-cognitive-load-balancing'
  spec.metadata['changelog_uri']     = 'https://github.com/LegionIO/lex-cognitive-load-balancing/blob/main/CHANGELOG.md'
  spec.metadata['bug_tracker_uri']   = 'https://github.com/LegionIO/lex-cognitive-load-balancing/issues'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir['lib/**/*']
end
