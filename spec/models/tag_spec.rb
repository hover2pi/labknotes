require 'spec_helper'

describe Tag do
  it "requires a name" do
    Factory.build(:tag, :name => nil).should_not be_valid
  end
  
  it "should have a unique name" do
    t = Factory(:tag)
    Factory.build(:tag, :name => t.name).should_not be_valid
  end

  it "should have many knotes" do
    t = Factory(:tag)
    k1 = Factory(:knote, :tag => t)
    k2 = Factory(:knote, :tag => t)
    t.knotes.count.should equal(2)
  end
end
