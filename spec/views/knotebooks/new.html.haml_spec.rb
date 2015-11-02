require 'spec_helper'

describe "knotebooks/new.html.haml" do
  before(:each) do
    assign(:knotebook, stub_model(Knotebook,
      :title => "MyString",
      :abstract => "MyText",
      :user => nil
    ).as_new_record)
  end

  it "renders new knotebook form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => knotebooks_path, :method => "post" do
      assert_select "input#knotebook_title", :name => "knotebook[title]"
      assert_select "textarea#knotebook_abstract", :name => "knotebook[abstract]"
      assert_select "input#knotebook_user", :name => "knotebook[user]"
    end
  end
end
