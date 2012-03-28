require 'rails/generators'
require 'rails/generators/migration'

module Accountable
  class MigrationsGenerator < Rails::Generators::Base
    include Rails::Generators::Migration

    # Implement the required interface for Rails::Generators::Migration.
    # taken from http://github.com/rails/rails/blob/master/activerecord/lib/generators/active_record.rb
    def self.next_migration_number(dirname)
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    end
  
    source_root File.expand_path("../templates", __FILE__)
  
    desc "Creates migrations."
    
    def create_migrations
      migration_template "accountable.rb.erb", "db/migrate/create_accountable_models.rb"
    end
  end
end
