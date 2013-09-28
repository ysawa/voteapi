require 'spec_helper'

describe "Votes" do
  describe "GET /votes" do
    it "errors" do
      get votes_path(format: :json)
      response.status.should be(403)
    end

    it "works with the vote category" do
      @vote = Fabricate(:vote)
      get votes_path(category: @vote.category, format: :json)
      response.status.should be(200)
    end
  end
end
