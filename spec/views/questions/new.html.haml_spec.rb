require 'spec_helper'

describe "questions/new.html.haml" do
  before(:each) do
    assign(:question, stub_model(Question,
      :title => "MyString",
      :explanation => "MyText",
      :position => 1,
      :knotebook => nil
    ).as_new_record)
  end

  it "renders new question form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => questions_path, :method => "post" do
      assert_select "input#question_title", :name => "question[title]"
      assert_select "textarea#question_explanation", :name => "question[explanation]"
      assert_select "input#question_position", :name => "question[position]"
      assert_select "input#question_knotebook", :name => "question[knotebook]"
    end
  end
end
