class ApplicationController < ActionController::Base
  # helper_method :current_student
  # helper_method :current_teacher
  before_action :login_required
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  # def current_student
  #   @current_student ||= Student.find_by(id: session[:student_id]) if session[:student_id]
  # end

  # def current_teacher
  #   @current_teacher ||= Teacher.find_by(id: session[:teacher_id]) if session[:teacher_id]
  # end

  def login_required
    redirect_to new_student_session_path unless current_student || current_teacher
  end
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:student, keys: [:name, :classroom_code])
    devise_parameter_sanitizer.permit(:teacher, keys: [:name])
  end


end
