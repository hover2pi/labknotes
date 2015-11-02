require 'spec_helper'

describe "knotebooks/show.html.haml" do
  before(:each) do
    @knotebook = assign(:knotebook, stub_model(Knotebook,
      :title => "Title",
      :abstract => "MyText",
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Title/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
