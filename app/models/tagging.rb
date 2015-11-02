class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :knote

  validates_uniqueness_of :knote_id, :scope => :tag_id
end
