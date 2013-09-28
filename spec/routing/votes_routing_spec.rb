require "spec_helper"

describe VotesController do
  describe "routing" do

    it "routes to #create" do
      post("/votes").should route_to("votes#create")
    end

    it "routes to #index" do
      get("/votes").should route_to("votes#index")
    end

    it "routes to #show" do
      get("/votes/1").should route_to("votes#show", :id => "1")
    end
  end
end
