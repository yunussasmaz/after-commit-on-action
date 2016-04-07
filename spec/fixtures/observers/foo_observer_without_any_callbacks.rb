class FooObserverWithoutAnyCallbacks < ActiveRecord::Observer
  observe :foo
end
