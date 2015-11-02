require 'spec_helper'

describe "knotes/index.html.haml" do
  before(:each) do
    assign(:knotes, [
      stub_model(Knote,
        :title => "Title",
        :content => "MyText",
        :user => nil
      ),
      stub_model(Knote,
        :title => "Title",
        :content => "MyText",
        :user => nil
      )
    ])
  end

  it "renders a list of knotes" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
