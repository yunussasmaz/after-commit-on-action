module AfterCommitOnAction
  extend ActiveSupport::Concern

  included do
    after_commit(on: :create) do |obj|
      obj.send :notify_observers, :after_commit_on_create
    end

    after_commit(on: :update) do |obj|
      obj.send :notify_observers, :after_commit_on_update
    end

    # Without the `if: :persisted?` condition,
    # this callback would be fired on destroy as well.
    after_commit(if: :persisted?) do |obj|
      obj.send :notify_observers, :after_commit_on_save
    end

    after_commit(on: :destroy) do |obj|
      obj.send :notify_observers, :after_commit_on_destroy
    end
  end
end

ActiveRecord::Base.send(:include, AfterCommitOnAction)
