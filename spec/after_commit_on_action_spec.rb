require 'spec_helper'

describe AfterCommitOnAction do
  context "[UserObserverWithCommitCreateUpdateSaveDestroy]" do
    it 'when a new record is created, it registers :commit, :save and :create, in this order' do
      user = User.create
      expect(user.called(:UserObserverWithCommitCreateUpdateSaveDestroy)).to eql([:commit, :save, :create])
    end

    it 'when a record is updated, it registers :commit, :save and :update, in this order' do
      user = User.create
      user.clear_called
      expect(user.called(:UserObserverWithCommitCreateUpdateSaveDestroy)).to eql([])
      user.update name: "Adam"
      expect(user.called(:UserObserverWithCommitCreateUpdateSaveDestroy)).to eql([:commit, :save, :update])
    end

    it 'when a record is destroyed, it registers :commit, :destroy, in this order' do
      user = User.create
      user.clear_called
      expect(user.called(:UserObserverWithCommitCreateUpdateSaveDestroy)).to eql([])
      user.destroy
      expect(user.called(:UserObserverWithCommitCreateUpdateSaveDestroy)).to eql([:commit, :destroy])
    end
  end

  context "[UserObserverWithoutAnyCallbacks]" do
    it 'when a new record is created, it does not register any of the after commit callbacks' do
      user = User.create
      expect(user.called(:UserObserverWithoutAnyCallbacks)).to eql([])
    end

    it 'when a record is updated, it does not register any of the after commit callbacks' do
      user = User.create
      user.clear_called
      expect(user.called(:UserObserverWithoutAnyCallbacks)).to eql([])
      user.update name: "Adam"
      expect(user.called(:UserObserverWithoutAnyCallbacks)).to eql([])
    end

    it 'when a record is destroyed, it does not register any of the after commit callbacks' do
      user = User.create
      user.clear_called
      expect(user.called(:UserObserverWithoutAnyCallbacks)).to eql([])
      user.destroy
      expect(user.called(:UserObserverWithoutAnyCallbacks)).to eql([])
    end
  end

  context "[UserObserverWithCommit]" do
    it 'when a new record is created, it registers :commit' do
      user = User.create
      expect(user.called(:UserObserverWithCommit)).to eql([:commit])
    end

    it 'when a new record is created, it registers :commit' do
      user = User.create
      user.clear_called
      expect(user.called(:UserObserverWithCommit)).to eql([])
      user.update name: "Adam"
      expect(user.called(:UserObserverWithCommit)).to eql([:commit])
    end

    it 'when a new record is created, it registers :commit' do
      user = User.create
      user.clear_called
      expect(user.called(:UserObserverWithCommit)).to eql([])
      user.destroy
      expect(user.called(:UserObserverWithCommit)).to eql([:commit])
    end
  end

  context "[UserObserverWithCreateSaveDestroy]" do
    it 'when a new record is created, it registers :save and :create, in this order' do
      user = User.create
      expect(user.called(:UserObserverWithCreateSaveDestroy)).to eql([:save, :create])
    end

    it 'when a record is updated, it registers :save' do
      user = User.create
      user.clear_called
      expect(user.called(:UserObserverWithCreateSaveDestroy)).to eql([])
      user.update name: "Adam"
      expect(user.called(:UserObserverWithCreateSaveDestroy)).to eql([:save])
    end

    it 'when a record is destroyed, it registers :destroy' do
      user = User.create
      user.clear_called
      expect(user.called(:UserObserverWithCreateSaveDestroy)).to eql([])
      user.destroy
      expect(user.called(:UserObserverWithCreateSaveDestroy)).to eql([:destroy])
    end
  end
end
