Gem::Specification.new do |s|
  s.name        = 'after-commit-on-action'
  s.version     = '0.0.2'
  s.date        = '2010-07-09'
  s.summary     = "Adds callbacks such as after_commit_on_create, after_commit_on_update to your ActiveRecord objects and observers."
  s.description = "Adds the following callbacks to your ActiveRecord objects and observers: after_commit_on_create, after_commit_on_update, after_commit_on_save, after_commit_on_destroy."
  s.authors     = ["Yunus Sasmaz"]
  s.email       = 'yunus@yunussasmaz.com'
  s.files       = ["lib/after-commit-on-action.rb", "after-commit-on-action.gemspec"]
  s.homepage    = 'https://github.com/yunussasmaz/after-commit-on-action'
  s.license     = 'MIT'

  s.add_runtime_dependency('rails', ['>= 4.0'])
  s.add_development_dependency('rspec', [">= 0"])
  s.add_development_dependency('sqlite', [">= 0"])
end
