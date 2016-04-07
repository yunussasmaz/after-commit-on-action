class FooObserverWithCommit < ActiveRecord::Observer
  observe :foo

  def after_commit(foo)
    foo.called(self, :commit)
  end
end
