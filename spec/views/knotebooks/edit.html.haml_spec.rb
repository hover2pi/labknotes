require 'spec_helper'

describe "knotebooks/edit.html.haml" do
  before(:each) do
    @knotebook = assign(:knotebook, stub_model(Knotebook,
      :new_record? => false,
      :title => "MyString",
      :abstract => "MyText",
      :user => nil
    ))
  end

  it "renders the edit knotebook form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => knotebook_path(@knotebook), :method => "post" do
      assert_select "input#knotebook_title", :name => "knotebook[title]"
      assert_select "textarea#knotebook_abstract", :name => "knotebook[abstract]"
      assert_select "input#knotebook_user", :name => "knotebook[user]"
    end
  end
end
