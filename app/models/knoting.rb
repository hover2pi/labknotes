class Knoting < ActiveRecord::Base
  belongs_to :knotebook
  belongs_to :knote

  scope :for, lambda { |object|
    case object
    when Knotebook
      where(:knotebook_id => object.id)
    when Knote
      where(:knote_id => object.id)
    end
  }
end
