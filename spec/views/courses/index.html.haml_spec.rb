require 'spec_helper'

describe "courses/index.html.haml" do
  before(:each) do
    assign(:courses, [
      stub_model(Course,
        :name => "Name",
        :semester => "Semester",
        :short_name => "Short Name"
      ),
      stub_model(Course,
        :name => "Name",
        :semester => "Semester",
        :short_name => "Short Name"
      )
    ])
  end

  it "renders a list of courses" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Semester".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Short Name".to_s, :count => 2
  end
end
