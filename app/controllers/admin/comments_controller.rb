module Admin
  class CommentsController < BaseController
    load_and_authorize_resource :course
    load_and_authorize_resource :student, :through => :course
    load_and_authorize_resource :report, :through => :student
    load_and_authorize_resource :answer, :through => :report
    load_and_authorize_resource :comment, :through => :answer
    
    def new
    end

    def create
      respond_to do |format|
        if @comment.save
          format.html { redirect_to([:admin, @course, @student, @report], :notice => 'Comment was successfully created.') }
        else
          format.html { render :action => "new" }
        end
      end
    end

    def edit
    end
    
    def update
      respond_to do |format|
        if @comment.update_attributes(params[:comment])
          format.html { redirect_to([:admin, @course, @student, @report], :notice => 'Comment was successfully updated.') }
        else
          format.html { render :edit }
        end
      end
    end
    
    def destroy
      @comment.destroy

      respond_to do |format|
        format.html { redirect_to([:admin, @course, @student, @report]) }
      end
    end
  end
end
