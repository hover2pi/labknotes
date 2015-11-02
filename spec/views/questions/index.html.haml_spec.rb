require 'spec_helper'

describe "questions/index.html.haml" do
  before(:each) do
    assign(:questions, [
      stub_model(Question,
        :title => "Title",
        :explanation => "MyText",
        :position => 1,
        :knotebook => nil
      ),
      stub_model(Question,
        :title => "Title",
        :explanation => "MyText",
        :position => 1,
        :knotebook => nil
      )
    ])
  end

  it "renders a list of questions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end