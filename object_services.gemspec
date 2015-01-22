$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'object_services/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'object_services'
  s.version     = ObjectServices::VERSION
  s.authors     = ['Tyler Davis']
  s.email       = ['tyler@tmd.io']
  s.homepage    = 'http://www.tmd.io'
  s.summary     = 'Services for rails.'
  s.description = 'A workspace for developing service objects.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '~> 4.2.0'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'simplecov'
end
