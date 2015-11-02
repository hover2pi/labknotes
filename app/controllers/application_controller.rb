class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    logger.debug "Access denied on #{exception.action} : #{exception.subject.inspect}"
    raise
  end
  
  def after_sign_in_path_for(resource)
    if resource.is_a? Professor
      admin_root_url
    else
      super
    end
  end
  
protected
  
  def load_student
    @student = current_user.is_a?(Student) ? current_user : Student.find(params[:student_id])
  end
  
  def load_swapped_knotes
    @swap = {}
    params[:knotes] ||= {}
    params[:knotes].each do |k, v|
      @swap[k.to_i] = Knote.find(v[:id])
    end
  end
  
end
