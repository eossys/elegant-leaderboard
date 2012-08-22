# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
$:.unshift File.dirname(__FILE__) + '/../lib'

require 'active_record'
require 'active_support/inflector'
require 'database_cleaner'
require 'sqlite3'
require 'standings'

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => ":memory:"
)

RSpec.configure do |config|
  config.before(:each) do
    DatabaseCleaner.start
  end
  config.after(:each) do
    DatabaseCleaner.clean
  end
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
end

ActiveRecord::Migration.verbose = false

ActiveRecord::Schema.define do
  create_table :game_users do |t|
    t.string :name
    t.float :score, :default => 0.0
    t.integer :age, :default => 20
    t.timestamps
  end
  
  create_table :products do |t|
    t.string :name
    t.float :price, :default => 0.0
    t.integer :review, :default => 1
    t.timestamps
  end

  create_table :students do |t|
    t.string :name
    t.float :score, :default => 0.0
    t.integer :age, :default => 5
    t.timestamps
  end
end

class GameUser < ActiveRecord::Base
  #rank_by column_name array_of_sort_column_names hash_of_options
  rank_by :score, :sort_order => ["name", "age DESC"], :around_limit => 2
end

class Product < ActiveRecord::Base
  #rank_by column_name array_of_sort_column_names hash_of_options
  rank_by :price, :sort_order => %w(name), :around_limit => 3
end

class Student < ActiveRecord::Base
  #rank_by column_name array_of_sort_column_names hash_of_options
  # Default Sort Order will be ID for students with equal score.
  rank_by :score
end
