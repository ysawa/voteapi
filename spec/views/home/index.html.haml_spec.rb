require 'spec_helper'

describe "home/index.html.haml" do
  it 'renders just text' do
   render
   rendered.should have_content 'API'
  end
end
