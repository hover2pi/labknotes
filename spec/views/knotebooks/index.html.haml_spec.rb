require 'spec_helper'

describe "knotebooks/index.html.haml" do
  before(:each) do
    assign(:knotebooks, [
      stub_model(Knotebook,
        :title => "Title",
        :abstract => "MyText",
        :user => nil
      ),
      stub_model(Knotebook,
        :title => "Title",
        :abstract => "MyText",
        :user => nil
      )
    ])
  end

  it "renders a list of knotebooks" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
