class StudentsController < ApplicationController
  load_and_authorize_resource :course, :through => :current_user
  load_and_authorize_resource :student, :through => :current_user

  def show
    @student = current_user.student? ? current_user : @course.students.find(params[:id])
  end
end
