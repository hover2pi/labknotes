class Enrollment < ActiveRecord::Base
  belongs_to :student
  belongs_to :course

  validates_uniqueness_of :student_id, :scope => :course_id, :message => "can only enroll once per course"
  
  def index
    @students = @course.students.all
  end
  
end
