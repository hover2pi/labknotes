require 'spec_helper'

describe "courses/show.html.haml" do
  before(:each) do
    @course = assign(:course, stub_model(Course,
      :name => "Name",
      :semester => "Semester",
      :short_name => "Short Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Semester/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Short Name/)
  end
end
