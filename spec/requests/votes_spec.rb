require 'spec_helper'

describe "Votes" do
  describe "GET /votes" do
    it "generates error" do
      get votes_path(format: :json)
      response.status.should be(403)
      parsed = JSON.parse response.body
      parsed['message'].should == 'NG'
    end

    it "works with the vote category" do
      @vote = Fabricate(:vote)
      get votes_path(category: @vote.category, format: :json)
      response.status.should be(200)
      parsed = JSON.parse response.body
      parsed['message'].should == 'OK'
    end
  end

  describe "POST /votes" do
    it "generates error" do
      post votes_path(vote: { category: 'category' }, format: :json)
      response.status.should be(422)
      post votes_path(vote: { name: 'name' }, format: :json)
      response.status.should be(422)
      parsed = JSON.parse response.body
      parsed['message'].should == 'NG'
    end

    it "works with the vote category" do
      @vote = Fabricate(:vote)
      post votes_path(vote: { category: 'category', name: 'name' }, format: :json)
      response.status.should be(201)
      parsed = JSON.parse response.body
      parsed['message'].should == 'OK'
    end
  end

  describe "GET /votes/count" do
    before :each do
      @another_vote = Fabricate(:vote, category: 'another')
      @first_vote = Fabricate(:vote, category: 'category')
      @second_vote = Fabricate(:vote, category: 'category')
    end

    it "generates error" do
      get count_votes_path(format: :json)
      parsed = JSON.parse response.body
      parsed['message'].should == 'NG'
    end

    it "generates counting json" do
      get count_votes_path(category: 'category', format: :json)
      parsed = JSON.parse response.body
      parsed['message'].should == 'OK'
      parsed['count'].should == 2
      get count_votes_path(category: 'another', format: :json)
      parsed = JSON.parse response.body
      parsed['message'].should == 'OK'
      parsed['count'].should == 1
    end
  end

  describe "GET /votes/ranking" do
    before :each do
      @another_vote = Fabricate(:vote, category: 'another', name: 'first')
      @first_vote = Fabricate(:vote, category: 'category', name: 'first')
      @second_vote = Fabricate(:vote, category: 'category', name: 'second')
    end

    it "generates error" do
      get ranking_votes_path(format: :json)
      parsed = JSON.parse response.body
      parsed['message'].should == 'NG'
    end

    it "generates rankinging json" do
      get ranking_votes_path(category: 'category', format: :json)
      parsed = JSON.parse response.body
      parsed['message'].should == 'OK'
      parsed['ranking'].should be_a Array
      parsed['ranking'][0]['name'].should == 'name'
      get ranking_votes_path(category: 'another', format: :json)
      parsed = JSON.parse response.body
      parsed['message'].should == 'OK'
      parsed['ranking'].should be_a Array
    end
  end
end
