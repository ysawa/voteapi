require 'spec_helper'

describe Vote do

  describe '#initialize' do
    it 'build new object' do
      vote = Vote.new
      vote.should_not be_persisted
    end
  end

  describe '#created_at' do
    it 'is nil when initialized' do
      vote = Vote.new
      vote.created_at.should be_nil
    end

    it 'is generated when created' do
      vote = Vote.create
      vote.created_at.should_not be_nil
    end
  end
end
