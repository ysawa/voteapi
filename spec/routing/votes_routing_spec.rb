require "spec_helper"

describe VotesController do
  describe "routing" do

    it "routes to #create" do
      post("/votes").should route_to("votes#create")
    end

    it "routes to #index" do
      get("/votes").should route_to("votes#index")
    end
  end
end
