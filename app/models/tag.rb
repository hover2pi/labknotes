class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :knotes, :through => :taggings
  
  validates_presence_of :name, :nil => false
  validates_uniqueness_of :name
end
