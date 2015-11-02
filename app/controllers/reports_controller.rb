class ReportsController < ApplicationController
  load_and_authorize_resource :course, :through => :current_user
  load_and_authorize_resource :student
  load_and_authorize_resource :report, :through => :current_user
  
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reports }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @report }
    end
  end

  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @report }
    end
  end

  def edit
  end

  def create
    respond_to do |format|
      if @report.save
        format.html { redirect_to([@course, current_user, @report], :notice => 'Report was successfully created.') }
        format.xml  { render :xml => @report, :status => :created, :location => @report }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @report.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @report.update_attributes(params[:report])
        @report.submit! if params[:commit] == "Submit report for grading"
        format.html { redirect_to([@course, current_user, @report], :notice => 'Report was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @report.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @report.destroy

    respond_to do |format|
      format.html { redirect_to(reports_url) }
      format.xml  { head :ok }
    end
  end
end
