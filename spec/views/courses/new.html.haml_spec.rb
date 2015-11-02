require 'spec_helper'

describe "courses/new.html.haml" do
  before(:each) do
    assign(:course, stub_model(Course,
      :name => "MyString",
      :semester => "MyString",
      :short_name => "MyString"
    ).as_new_record)
  end

  it "renders new course form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => courses_path, :method => "post" do
      assert_select "input#course_name", :name => "course[name]"
      assert_select "input#course_semester", :name => "course[semester]"
      assert_select "input#course_short_name", :name => "course[short_name]"
    end
  end
end
