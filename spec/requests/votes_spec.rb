require 'spec_helper'

describe "Votes" do
  describe "GET /votes" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get votes_path(format: :json)
      response.status.should be(200)
    end
  end
end
