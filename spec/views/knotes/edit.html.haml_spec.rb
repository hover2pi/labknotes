require 'spec_helper'

describe "knotes/edit.html.haml" do
  before(:each) do
    @knote = assign(:knote, stub_model(Knote,
      :new_record? => false,
      :title => "MyString",
      :content => "MyText",
      :user => nil
    ))
  end

  it "renders the edit knote form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => knote_path(@knote), :method => "post" do
      assert_select "input#knote_title", :name => "knote[title]"
      assert_select "textarea#knote_content", :name => "knote[content]"
      assert_select "input#knote_user", :name => "knote[user]"
    end
  end
end
