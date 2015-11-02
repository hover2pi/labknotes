require 'spec_helper'

describe Knotebook do
  it "requires a title" do
    Factory.build(:knotebook, :title => nil).should_not be_valid
  end

  it "requires an abstract" do
    Factory.build(:knotebook, :abstract => nil).should_not be_valid
  end
  
  it "should have a valid factory" do
    Factory.build(:knotebook).should be_valid
  end
  
  it "should have many tags" do
    kb = Factory.create(:knotebook)
    kb.knotes << Factory.create(:knote)
    kb.knotes << Factory.create(:knote)
    kb.tags.count.should equal(2)
  end
  
  # it "should know about knote positioning" do
  #   kb = Factory.create(:knotebook)
  #   kn_1 = Factory.create(:knote)
  #   kn_2 = Factory.create(:knote)
  #   kb.knotes << kn_1
  #   kb.knotes << kn_2
  #   kb.kn
  # end
end
