class FooObserverWithCreateSaveDestroy < ActiveRecord::Observer
  observe :foo

  def after_commit_on_create(foo)
    foo.called(self, :create)
  end

  def after_commit_on_save(foo)
    foo.called(self, :save)
  end

  def after_commit_on_destroy(foo)
    foo.called(self, :destroy)
  end
end
