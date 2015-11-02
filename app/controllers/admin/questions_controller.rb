module Admin
  class QuestionsController < ApplicationController
    load_and_authorize_resource :course
    load_and_authorize_resource :knotebook, :through => :course
    load_and_authorize_resource :question, :through => :knotebook

    def index
      respond_to do |format|
        format.html
      end
    end

    # GET /questions/1
    # GET /questions/1.xml
    def show
      @question = Question.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @question }
      end
    end

    def new
      respond_to do |format|
        format.html
      end
    end

    def edit
    end

    def create
      @question = @knotebook.questions.build(params[:question])

      respond_to do |format|
        if @question.save
          format.html { redirect_to([:admin, @course, @knotebook, :questions], :notice => 'Question was successfully created.') }
        else
          format.html { render :action => "new" }
        end
      end
    end

    # PUT /questions/1
    # PUT /questions/1.xml
    def update
      @question = Question.find(params[:id])

      respond_to do |format|
        if @question.update_attributes(params[:question])
          format.html { redirect_to([:admin, @course, @knotebook, :questions], :notice => 'Question was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /questions/1
    # DELETE /questions/1.xml
    def destroy
      @question = Question.find(params[:id])
      @question.destroy

      respond_to do |format|
        format.html { redirect_to(questions_url) }
        format.xml  { head :ok }
      end
    end
  end
end
