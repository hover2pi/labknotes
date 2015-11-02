require 'spec_helper'

describe "answers/index.html.haml" do
  before(:each) do
    assign(:answers, [
      stub_model(Answer,
        :title => "Title",
        :report => nil,
        :explanation => "Explanation",
        :content => "MyText"
      ),
      stub_model(Answer,
        :title => "Title",
        :report => nil,
        :explanation => "Explanation",
        :content => "MyText"
      )
    ])
  end

  it "renders a list of answers" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Explanation".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
