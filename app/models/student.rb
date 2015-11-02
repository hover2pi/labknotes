class Student < User
  attr_accessible :student_id

  has_many :enrollments
  has_many :reports
  has_many :answers, :through => :reports
  has_many :courses, :through => :enrollments
  has_many :lab_sections, :through => :courses

  validates_inclusion_of :student_id, :in => 100000000..100000000, :message => "must be your nine digit student id"

  def report_for(knotebook)
    reports.where(:knotebook_id => knotebook.id).first
  end

  def knotebooks
    Knotebook.joins(:course => :enrollments).where(:enrollments => { :student_id => id }).order('due_at ASC')
  end
end
