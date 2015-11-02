require 'spec_helper'

describe "reports/show.html.haml" do
  before(:each) do
    @report = assign(:report, stub_model(Report,
      :user => nil,
      :knotebook => nil,
      :grade => 1.5,
      :state => "State"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/State/)
  end
end
