class FooObserverWithCommitCreateUpdateSaveDestroy < ActiveRecord::Observer
  observe :foo

  def after_commit(foo)
    foo.called(self, :commit)
  end

  def after_commit_on_create(foo)
    foo.called(self, :create)
  end

  def after_commit_on_update(foo)
    foo.called(self, :update)
  end

  def after_commit_on_save(foo)
    foo.called(self, :save)
  end

  def after_commit_on_destroy(foo)
    foo.called(self, :destroy)
  end
end
