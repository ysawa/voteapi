require 'spec_helper'

describe VotesController do

  # This should return the minimal set of attributes required to create a valid
  # Vote. As you add validations to Vote, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "category" => "category", "name" => 'name' } }

  describe "GET index" do
    it "assigns all votes as @votes" do
      vote = Vote.create! valid_attributes
      get :index, { format: 'json' }
      assigns(:votes).should eq([vote])
    end
  end

  describe "GET count" do
    before :each do
      @another_vote = Fabricate(:vote, category: 'another')
      @first_vote = Fabricate(:vote, category: 'category', name: 'first')
      @second_vote = Fabricate(:vote, category: 'category', name: 'second')
      @third_vote = Fabricate(:vote, category: 'category', name: 'first')
    end

    it "assigns all votes as @votes" do
      get :count, { category: 'category', format: 'json' }
      assigns(:votes).should include @first_vote
      assigns(:votes).should include @second_vote
      assigns(:votes).should include @third_vote
      assigns(:votes).should_not include @another_vote
    end
  end

  describe "GET ranking" do
    before :each do
      @another_vote = Fabricate(:vote, category: 'another')
      @first_vote = Fabricate(:vote, category: 'category', name: 'first')
      @second_vote = Fabricate(:vote, category: 'category', name: 'second')
      @third_vote = Fabricate(:vote, category: 'category', name: 'first')
    end

    it "assigns all votes as @votes" do
      get :ranking, { category: 'category', format: 'json' }
      assigns(:votes).should include @first_vote
      assigns(:votes).should include @second_vote
      assigns(:votes).should include @third_vote
      assigns(:votes).should_not include @another_vote
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Vote" do
        expect {
          post :create, {vote: valid_attributes, format: 'json'}
        }.to change(Vote, :count).by(1)
      end

      it "assigns a newly created vote as @vote" do
        post :create, {vote: valid_attributes, format: 'json'}
        vote = assigns(:vote)
        vote.should be_a(Vote)
        vote.should be_persisted
        vote.remote_ip.should_not be_blank
        vote.user_agent.should_not be_blank
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved vote as @vote" do
        # Trigger the behavior that occurs when invalid params are submitted
        Vote.any_instance.stub(:save).and_return(false)
        post :create, {vote: { "category" => "invalid value" }, format: 'json'}
        assigns(:vote).should be_a_new(Vote)
      end
    end

    describe 'forbits the same user' do
      it "assigns a newly created but unsaved vote as @vote" do
        post :create, {vote: valid_attributes, format: 'json'}
        post :create, {vote: valid_attributes, format: 'json'}
        assigns(:vote).should be_a_new(Vote)
      end
    end
  end
end
