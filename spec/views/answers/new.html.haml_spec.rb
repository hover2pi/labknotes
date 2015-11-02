require 'spec_helper'

describe "answers/new.html.haml" do
  before(:each) do
    assign(:answer, stub_model(Answer,
      :title => "MyString",
      :report => nil,
      :explanation => "MyString",
      :content => "MyText"
    ).as_new_record)
  end

  it "renders new answer form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => answers_path, :method => "post" do
      assert_select "input#answer_title", :name => "answer[title]"
      assert_select "input#answer_report", :name => "answer[report]"
      assert_select "input#answer_explanation", :name => "answer[explanation]"
      assert_select "textarea#answer_content", :name => "answer[content]"
    end
  end
end
