module Admin
  class EnrollmentsController < BaseController
    load_and_authorize_resource :course
    load_and_authorize_resource :enrollment, :through => :course
    
    def new
    end
    
    def create
      student = @enrollment.student
      
      if @enrollment.save
        respond_to do |format|
          format.html { redirect_to [:admin, @course], :notice => "#{student.name} was successfully added to #{@course.short_name}" }
        end
      else
        respond_to do |format|
          format.html { render :action => 'new' }
        end
      end
    end
  end
end
