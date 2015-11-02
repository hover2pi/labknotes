class Course < ActiveRecord::Base
  belongs_to :professor
  has_many :enrollments
  has_many :lab_sections
  has_many :students, :through => :enrollments
  has_many :knotebooks
  has_many :reports, :through => :knotebooks

  validates_presence_of :professor_id
  validates_presence_of :syllabus
  validates_presence_of :name
  validates_presence_of :short_name
  validates_presence_of :semester
  
end
