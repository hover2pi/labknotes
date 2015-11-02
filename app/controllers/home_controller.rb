class HomeController < ApplicationController
  VALID_PAGES = /about/

  def index
    if user_signed_in?
      if current_user.is_a?(Professor)
        redirect_to [:admin, :root]
      else
        render 'home'
      end
    end
  end

  def show
    render params[:id]
  end

end
