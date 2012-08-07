$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "accountable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "accountable"
  s.version     = Accountable::VERSION
  s.authors     = ["Jim Van Fleet", "Jay McAliley"]
  s.email       = ["jim@jimvanfleet.com"]
  s.homepage    = "http://bigfleet.github.com/accountable"
  s.summary     = "Flexible double-entry accounting engine for Rails apps"
  s.description = "Double-entry accounting issues credits and debits, calculates balances, allows for summary accounts and more."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", ">= 3.0.0"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
