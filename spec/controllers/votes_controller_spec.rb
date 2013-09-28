require 'spec_helper'

describe VotesController do

  # This should return the minimal set of attributes required to create a valid
  # Vote. As you add validations to Vote, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "category" => "MyString" } }

  describe "GET index" do
    it "assigns all votes as @votes" do
      vote = Vote.create! valid_attributes
      get :index, { format: 'json' }
      assigns(:votes).should eq([vote])
    end
  end

  describe "GET show" do
    it "assigns all votes as @votes" do
      vote = Vote.create! valid_attributes
      get :show, { id: vote.to_param, format: 'json' }
      assigns(:vote).should eq(vote)
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
        assigns(:vote).should be_a(Vote)
        assigns(:vote).should be_persisted
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
  end
end
