class CoursesController < ApplicationController
  load_and_authorize_resource :course, :through => :current_user

  def index
    respond_to do |format|
      format.html
    end
  end

  def show
    respond_to do |format|
      format.html
    end
  end
end
