module AfterCommitOnAction
  extend ActiveSupport::Concern

  included do
    after_commit(on: :create)     { |obj| obj.send :notify_observers, :after_commit_on_create  }
    after_commit(on: :update)     { |obj| obj.send :notify_observers, :after_commit_on_update  }
    after_commit(if: :persisted?) { |obj| obj.send :notify_observers, :after_commit_on_save    }
    after_commit(on: :destroy)    { |obj| obj.send :notify_observers, :after_commit_on_destroy }
  end
end

ActiveRecord::Base.send(:include, AfterCommitOnAction)
