require 'spec_helper'

describe "reports/index.html.haml" do
  before(:each) do
    assign(:reports, [
      stub_model(Report,
        :user => nil,
        :knotebook => nil,
        :grade => 1.5,
        :state => "State"
      ),
      stub_model(Report,
        :user => nil,
        :knotebook => nil,
        :grade => 1.5,
        :state => "State"
      )
    ])
  end

  it "renders a list of reports" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "State".to_s, :count => 2
  end
end
