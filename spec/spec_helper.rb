require 'bundler'
require 'rubygems'
require 'rails'
require 'rspec'
require 'active_record'
require 'rails/observers/activerecord/active_record'
require 'after-commit-on-action'

Bundler.require :test
ENV["RAILS_ENV"] ||= 'test'

ActiveRecord::Base.establish_connection(
    :adapter => 'sqlite3',
    :database => ':memory:'
)

ActiveRecord::Migration.verbose = false

# CREATE A MOCK MODEL

Dir['./spec/fixtures/**/*.rb'].each { |f| require f }

ActiveRecord::Schema.define(:version => 1) do
  create_table "foos" do |t|
    t.string :name
  end
end

Foo.observers = [
    :foo_observer_with_commit_create_update_save_destroy,
    :foo_observer_without_any_callbacks,
    :foo_observer_with_commit,
    :foo_observer_with_create_save_destroy
]
Foo.instantiate_observers
