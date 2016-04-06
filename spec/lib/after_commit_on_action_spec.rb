require 'spec_helper'

describe AfterCommitOnAction do
  context "[FooObserverWithCommitCreateUpdateSaveDestroy]" do
    it 'when a new record is created, it registers :commit, :save and :create, in this order' do
      foo = Foo.create
      expect(foo.called(:FooObserverWithCommitCreateUpdateSaveDestroy)).to eql([:commit, :save, :create])
    end

    it 'when a record is updated, it registers :commit, :save and :update, in this order' do
      foo = Foo.create
      foo.clear_called
      expect(foo.called(:FooObserverWithCommitCreateUpdateSaveDestroy)).to eql([])
      foo.update name: "Adam"
      expect(foo.called(:FooObserverWithCommitCreateUpdateSaveDestroy)).to eql([:commit, :save, :update])
    end

    it 'when a record is destroyed, it registers :commit, :destroy, in this order' do
      foo = Foo.create
      foo.clear_called
      expect(foo.called(:FooObserverWithCommitCreateUpdateSaveDestroy)).to eql([])
      foo.destroy
      expect(foo.called(:FooObserverWithCommitCreateUpdateSaveDestroy)).to eql([:commit, :destroy])
    end
  end

  context "[FooObserverWithoutAnyCallbacks]" do
    it 'when a new record is created, it does not register any of the after commit callbacks' do
      foo = Foo.create
      expect(foo.called(:FooObserverWithoutAnyCallbacks)).to eql([])
    end

    it 'when a record is updated, it does not register any of the after commit callbacks' do
      foo = Foo.create
      foo.clear_called
      expect(foo.called(:FooObserverWithoutAnyCallbacks)).to eql([])
      foo.update name: "Adam"
      expect(foo.called(:FooObserverWithoutAnyCallbacks)).to eql([])
    end

    it 'when a record is destroyed, it does not register any of the after commit callbacks' do
      foo = Foo.create
      foo.clear_called
      expect(foo.called(:FooObserverWithoutAnyCallbacks)).to eql([])
      foo.destroy
      expect(foo.called(:FooObserverWithoutAnyCallbacks)).to eql([])
    end
  end

  context "[FooObserverWithCommit]" do
    it 'when a new record is created, it registers :commit' do
      foo = Foo.create
      expect(foo.called(:FooObserverWithCommit)).to eql([:commit])
    end

    it 'when a new record is created, it registers :commit' do
      foo = Foo.create
      foo.clear_called
      expect(foo.called(:FooObserverWithCommit)).to eql([])
      foo.update name: "Adam"
      expect(foo.called(:FooObserverWithCommit)).to eql([:commit])
    end

    it 'when a new record is created, it registers :commit' do
      foo = Foo.create
      foo.clear_called
      expect(foo.called(:FooObserverWithCommit)).to eql([])
      foo.destroy
      expect(foo.called(:FooObserverWithCommit)).to eql([:commit])
    end
  end

  context "[FooObserverWithCreateSaveDestroy]" do
    it 'when a new record is created, it registers :save and :create, in this order' do
      foo = Foo.create
      expect(foo.called(:FooObserverWithCreateSaveDestroy)).to eql([:save, :create])
    end

    it 'when a record is updated, it registers :save' do
      foo = Foo.create
      foo.clear_called
      expect(foo.called(:FooObserverWithCreateSaveDestroy)).to eql([])
      foo.update name: "Adam"
      expect(foo.called(:FooObserverWithCreateSaveDestroy)).to eql([:save])
    end

    it 'when a record is destroyed, it registers :destroy' do
      foo = Foo.create
      foo.clear_called
      expect(foo.called(:FooObserverWithCreateSaveDestroy)).to eql([])
      foo.destroy
      expect(foo.called(:FooObserverWithCreateSaveDestroy)).to eql([:destroy])
    end
  end
end
