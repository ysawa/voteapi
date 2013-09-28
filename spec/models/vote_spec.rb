require 'spec_helper'

describe Vote do

  describe '#category' do
    it 'validates the presence' do
      vote = Fabricate.build(:vote, category: nil)
      vote.should_not be_valid
      vote.category = 'category'
      vote.should be_valid
    end
  end

  describe '#name' do
    it 'validates the presence' do
      vote = Fabricate.build(:vote, name: nil)
      vote.should_not be_valid
      vote.name = 'name'
      vote.should be_valid
    end
  end

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
      vote = Fabricate(:vote)
      vote.created_at.should_not be_nil
    end
  end

  describe '#suspicious?' do

    it 'returns false if the last vote is blank' do
      vote = Fabricate.build(:vote, name: 'name2', remote_ip: '192.168.1.10', user_agent: 'bar')
      vote.suspicious?.should be_false
    end

    it 'checks the last_one' do
      @vote = Fabricate(:vote, name: 'name2', remote_ip: '192.168.1.3', user_agent: 'foo')
      vote = Fabricate.build(:vote, name: 'name2', remote_ip: '192.168.1.10', user_agent: 'bar')
      vote.suspicious?.should be_false
      vote = Fabricate.build(:vote, name: 'name2', remote_ip: '192.168.1.10', user_agent: 'foo')
      vote.suspicious?.should be_false
      vote = Fabricate.build(:vote, name: 'name2', remote_ip: '192.168.1.3', user_agent: 'bar')
      vote.suspicious?.should be_false
      vote = Fabricate.build(:vote, name: 'name2', remote_ip: '192.168.1.3', user_agent: 'foo')
      vote.suspicious?.should be_true
    end

    it 'ignores the last vote over the limit' do
      @vote = Fabricate(:vote, name: 'name2', remote_ip: '192.168.1.3', user_agent: 'foo')
      vote = @vote.dup
      vote.suspicious?.should be_true
      @vote.created_at = Time.now - Voteapi::VOTE_SPAN + 1.second
      @vote.save
      vote.suspicious?.should be_true
      @vote.created_at = Time.now - Voteapi::VOTE_SPAN - 1.second
      @vote.save
      vote.suspicious?.should be_false
      @vote.created_at = Time.now - Voteapi::VOTE_SPAN * 2
      @vote.save
      vote.suspicious?.should be_false
    end
  end

  describe '.category' do

    before :each do
      @another_vote = Fabricate(:vote, category: 'another')
      @vote = Fabricate(:vote, category: 'vote')
    end

    it 'finds the last vote' do
      Vote.category('vote').to_a.should == [@vote]
      Vote.category('another').to_a.should == [@another_vote]
    end
  end

  describe '.last_one' do

    before :each do
      @old_another_vote = Fabricate(:vote, category: 'another', created_at: 2.minutes.ago)
      @another_vote = Fabricate(:vote, category: 'another', created_at: 1.minutes.ago)
      @old_vote = Fabricate(:vote, category: 'vote', created_at: 1.minutes.ago)
      @vote = Fabricate(:vote, category: 'vote')
    end

    it 'finds the last vote' do
      Vote.last_one.should == @vote
    end

    it 'finds the last vote from category' do
      Vote.last_one(@vote.category).should == @vote
      Vote.last_one(@another_vote.category).should == @another_vote
    end
  end

  describe '.of_name' do

    before :each do
      @another_vote = Fabricate(:vote, name: 'another')
      @vote = Fabricate(:vote, name: 'vote')
    end

    it 'finds the last vote' do
      Vote.of_name('vote').to_a.should == [@vote]
      Vote.of_name('another').to_a.should == [@another_vote]
    end
  end
end
