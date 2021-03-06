require "spec_helper"

describe VotesController do
  describe "routing" do

    it "routes to #count" do
      get("/votes/count").should route_to("votes#count")
    end

    it "routes to #create" do
      post("/votes").should route_to("votes#create")
    end

    it "routes to #destroy" do
      delete("/votes/1").should route_to("votes#destroy", id: '1')
    end

    it "routes to #index" do
      get("/votes").should route_to("votes#index")
    end

    it "routes to #new" do
      get("/votes/new").should route_to("votes#new")
    end

    it "routes to #ranking" do
      get("/votes/ranking").should route_to("votes#ranking")
    end
  end
end
