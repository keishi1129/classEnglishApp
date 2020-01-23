class ApplicationController < ActionController::Base
  helper_method :current_student
  helper_method :current_teacher
  before_action :login_required

  private

  def current_student
    @current_student ||= Student.find_by(id: session[:student_id]) if session[:student_id]
  end

  def current_teacher
    @current_teacher ||= Teacher.find_by(id: session[:teacher_id]) if session[:teacher_id]
  end

  def login_required
    redirect_to login_url unless current_student || current_teacher
  end



end
