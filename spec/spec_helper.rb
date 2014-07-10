require 'bundler'
require 'rubygems'
require 'rails'
require 'rspec'
require 'active_record'
require "rails/observers/activerecord/active_record"
require 'after-commit-on-action'

Bundler.require :test
ENV["RAILS_ENV"] ||= 'test'

ActiveRecord::Base.establish_connection(
    :adapter  => 'sqlite3',
    :database => ':memory:'
)

ActiveRecord::Migration.verbose = false

ActiveRecord::Schema.define(:version => 1) do
  create_table "users" do |t|
    t.string :name
  end
end

class User < ActiveRecord::Base
  def called(observer, action=nil)
    @called ||= {}
    observer = observer.class.to_s.to_sym unless observer.is_a?(Symbol)
    @called[observer] ||= []
    if action && observer
      @called[observer] << action
    else
      @called[observer]
    end
  end

  def clear_called
    @called = {}
  end
end

class UserObserverWithCommitCreateUpdateSaveDestroy < ActiveRecord::Observer
  observe :user

  def after_commit(user);            user.called(self, :commit);  end
  def after_commit_on_create(user);  user.called(self, :create);  end
  def after_commit_on_update(user);  user.called(self, :update);  end
  def after_commit_on_save(user);    user.called(self, :save);    end
  def after_commit_on_destroy(user); user.called(self, :destroy); end
end

class UserObserverWithoutAnyCallbacks < ActiveRecord::Observer
  observe :user
end

class UserObserverWithCommit < ActiveRecord::Observer
  observe :user

  def after_commit(user);            user.called(self, :commit);  end
end

class UserObserverWithCreateSaveDestroy < ActiveRecord::Observer
  observe :user

  def after_commit_on_create(user);  user.called(self, :create);  end
  def after_commit_on_save(user);    user.called(self, :save);    end
  def after_commit_on_destroy(user); user.called(self, :destroy); end
end

User.observers = :user_observer_with_commit_create_update_save_destroy,
                  :user_observer_without_any_callbacks,
                  :user_observer_with_commit,
                  :user_observer_with_create_save_destroy
User.instantiate_observers
