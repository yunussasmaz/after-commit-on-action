class Foo < ActiveRecord::Base
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
