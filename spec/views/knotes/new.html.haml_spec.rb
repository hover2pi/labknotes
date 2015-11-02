require 'spec_helper'

describe "knotes/new.html.haml" do
  before(:each) do
    assign(:knote, stub_model(Knote,
      :title => "MyString",
      :content => "MyText",
      :user => nil
    ).as_new_record)
  end

  it "renders new knote form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => knotes_path, :method => "post" do
      assert_select "input#knote_title", :name => "knote[title]"
      assert_select "textarea#knote_content", :name => "knote[content]"
      assert_select "input#knote_user", :name => "knote[user]"
    end
  end
end
