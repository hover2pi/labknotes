class Question < ActiveRecord::Base
  alias_attribute :content, :explanation

  belongs_to :knotebook

  acts_as_list :scope => :knotebook
  
  validates_presence_of :title, :explanation, :nil => false

  default_scope order("position ASC")

end
