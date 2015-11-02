class KnotebooksController < ApplicationController  
  load_and_authorize_resource :course, :through => :current_user
  load_and_authorize_resource :knotebook, :through => :course
  
  def index
    @knotebooks = @course.knotebooks

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @knotebook = @course.knotebooks.find(params[:id])
    load_swapped_knotes
    
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def favorite
    @knotebook = Knotebook.find(params[:id])
    @favorite = @knotebook.clone
    
    @favorite.favorite = true
    @favorite.user = current_user

    params[:knotes] ||= {}
    
    @knotebook.knotes.each_with_index do |knote, index|
      id = params[:knotes][index.to_s]
      @favorite.knotes << (id.blank? ? knote : Knote.find(id[:id]))
    end
    
    respond_to do |format|
      if @favorite.save
        format.html { redirect_to [@course, @favorite], :notice => "Favorite created successfully!" }
      else
        # TODO: redirect to the original and maintain favorite params
        format.html { redirect_to [@course, @knotebook], :notice => "There was a problem creating favoriting this Knotebook, please try again" }
      end
    end
  end
end
