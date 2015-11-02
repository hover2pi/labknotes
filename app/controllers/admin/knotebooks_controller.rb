module Admin
  class KnotebooksController < BaseController
    load_and_authorize_resource :course
    load_and_authorize_resource :knotebook, :through => :course
    before_filter :set_professor, :only => [:create, :update]

    def index
      respond_to do |format|
        format.html
      end
    end

    def show
      load_swapped_knotes
    end

    def new
      respond_to do |format|
        format.html
      end
    end

    def edit
      respond_to do |format|
        format.html
      end
    end

    def create
      respond_to do |format|
        if @knotebook.save
          format.html { redirect_to([:admin, @course, @knotebook, :knotes], :notice => 'Experiment was successfully created.') }
        else
          format.html { render :action => "new" }
        end
      end
    end

    def update
      respond_to do |format|
        if @knotebook.update_attributes(params[:knotebook])
          format.html { redirect_to([:admin, @course, @knotebook], :notice => 'Experiment was successfully updated.') }
        else
          format.html { render :action => "edit" }
        end
      end
    end

    def destroy
      @knotebook.destroy

      respond_to do |format|
        format.html { redirect_to([:admin, :root], :notice => 'Experiment was successfully deleted.') }
      end
    end

    def publish
      if @knotebook.publishable?
        @knotebook.publish!
        redirect_to([:admin, @course, @knotebook], :notice => 'Experiment was successfully published!')
      else
        redirect_to [:admin, @course, @knotebook, :knotes]
      end
    end

  private

    def set_professor
      @knotebook.professor == current_user
    end
  end
end