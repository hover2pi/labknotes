module Admin
  class KnotesController < BaseController
    load_and_authorize_resource :course
    load_and_authorize_resource :knotebook, :through => :course
    load_and_authorize_resource :knote, :through => :knotebook

    def index
      respond_to do |format|
        format.html
      end
    end

    def show
      @knote = Knote.find(params[:id])
      @original = params[:original_id].nil? ? @knote : Knote.find(params[:original_id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @knote }
        format.js
      end
    end

    def new
      @original = Knote.find(params[:original_id]) if params[:original_id]
      respond_to do |format|
        format.html
      end
    end

    def edit
    end

    def create
      @original = Knote.find(params[:original_id]) if params[:original_id]

      respond_to do |format|
        if @knote.save
          # Manually build the knoting for now instead of using @knotebook.knotes << @knote
          if @original.is_a? Knote
            y = @original.knotings.for(@knotebook).first.y
            x = @knotebook.knotings.where(:y => y).order("x DESC").limit(1).select(:x).first.x + 1
          else
            x = 1
            last_knote = @knotebook.knotings.order("y DESC").limit(1).select(:y).first
            y = last_knote.nil? ? 1 : last_knote.y + 1
          end

          @knotebook.knotings.create(:knote_id => @knote.id, :x => x, :y => y)

          format.html { redirect_to([:admin, @course, @knotebook, :knotes], :notice => 'Knote was successfully created.') }
        else
          format.html { render :action => "new" }
        end
      end
    end

    # PUT /knotes/1
    # PUT /knotes/1.xml
    def update
      @knote = Knote.find(params[:id])

      respond_to do |format|
        if @knote.update_attributes(params[:knote])
          format.html { redirect_to([:admin, @course, @knotebook, :knotes], :notice => 'Knote was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @knote.errors, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /knotes/1
    # DELETE /knotes/1.xml
    def destroy
      @knote = Knote.find(params[:id])
      @knote.destroy

      respond_to do |format|
        format.html { redirect_to(knotes_url) }
        format.xml  { head :ok }
      end
    end
  end
end
