require 'spec_helper'

describe Knote do
  it "requires a title" do
    Factory.build(:knote, :title => nil).should_not be_valid
  end

  it "requires an abstract" do
    Factory.build(:knote, :content => nil).should_not be_valid
  end

  it "requires a tag" do
    Factory.build(:knote, :tag => nil).should_not be_valid
  end
  
  it "should have a valid factory" do
    Factory.build(:knote).should be_valid
  end
  
end
