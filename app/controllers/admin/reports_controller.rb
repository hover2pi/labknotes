module Admin
  class ReportsController < BaseController
    load_and_authorize_resource :course
    load_and_authorize_resource :student, :through => :course, :shallow => true
    load_and_authorize_resource :report, :through => :student, :shallow => true
    
    def index
      @knotebook = @course.knotebooks.find(params[:knotebook_id])
      @reports = @knotebook.reports
    end
    
    def show
    end
    
    def edit
    end
    
    def update
      respond_to do |format|
        @report.grade = params[:report][:grade]
        if @report.score
          format.html { redirect_to([:admin, @course, @student, @report], :notice => 'Report was successfully graded.') }
        else
          format.html { render :edit }
        end
      end
    end

    def return
      if @report.return
        redirect_to([:admin, @course, @student], :notice => 'Report was returned without a grade.') and return
      else
        render :edit and return
      end
    end
  end
end
