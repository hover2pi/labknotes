module Admin
  class StudentsController < BaseController
    load_and_authorize_resource :course
    load_and_authorize_resource :student, :through => :course

    def index
      @students = @course.students.all
    end

    def show
      @student = @course.students.find(params[:student_id]) if params[:student_id]
    end
  end
end
