After Commit on Action
======================

Move your `after_commit` callbacks to your Rails Observers.
 
If you are defining an `after_commit` block in your Rails model directly,
you have the option to specify when (on `create`, `update`, `destroy`) that block should be run.

Example:
```ruby
class Foo
  after_commit :on => :create do
    send_create_email
  end

  after_commit :on => :update do
    send_update_email
  end
  
  after_commit :on => :destroy do
    send_destroy_email
  end
end
```

If you wanted to move this code to your observers, you will find that you cannot specify the `on` option.
To remedy that limitation, this gem allows you to create the following callbacks in your Rails Observers:
- after_commit_on_create
- after_commit_on_update
- after_commit_on_save
- after_commit_on_destroy

Example:
```ruby
class Foo
end

class FooObserver < ActiveRecord::Observer
  observe :foo

  def after_commit_on_create(foo)
    send_create_email
  end

  def after_commit_on_update(foo)
    send_update_email
  end

  def after_commit_on_save(foo)
    send_save_email
  end

  def after_commit_on_destroy(foo)
    send_destroy_email
  end
```
