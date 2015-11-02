class Answer < ActiveRecord::Base
  belongs_to :report
  belongs_to :question
  has_many :comments, :as => :commentable

  default_scope joins(:question).order("questions.position ASC")
end
