class Professor < User
  has_many :courses
  has_many :lab_sections, :through => :courses
  has_many :knotebooks
  has_many :knotes, :through => :knotebooks
  has_many :reports, :through => :knotebooks
  has_many :enrollments, :through => :courses
  
  before_save :ensure_professor
  
  def ensure_professor
    professor! unless professor?
  end
end
