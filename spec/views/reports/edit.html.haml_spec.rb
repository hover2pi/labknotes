require 'spec_helper'

describe "reports/edit.html.haml" do
  before(:each) do
    @report = assign(:report, stub_model(Report,
      :user => nil,
      :knotebook => nil,
      :grade => 1.5,
      :state => "MyString"
    ))
  end

  it "renders the edit report form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => report_path(@report), :method => "post" do
      assert_select "input#report_user", :name => "report[user]"
      assert_select "input#report_knotebook", :name => "report[knotebook]"
      assert_select "input#report_grade", :name => "report[grade]"
      assert_select "input#report_state", :name => "report[state]"
    end
  end
end
