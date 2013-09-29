require "spec_helper"

describe 'votes/new' do
  before :each do
    assign :vote, Vote.new
  end

  it 'generates form' do
    render
    assert_select "form"
  end
end
