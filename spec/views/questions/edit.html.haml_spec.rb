require 'spec_helper'

describe "questions/edit.html.haml" do
  before(:each) do
    @question = assign(:question, stub_model(Question,
      :title => "MyString",
      :explanation => "MyText",
      :position => 1,
      :knotebook => nil
    ))
  end

  it "renders the edit question form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => question_path(@question), :method => "post" do
      assert_select "input#question_title", :name => "question[title]"
      assert_select "textarea#question_explanation", :name => "question[explanation]"
      assert_select "input#question_position", :name => "question[position]"
      assert_select "input#question_knotebook", :name => "question[knotebook]"
    end
  end
end
