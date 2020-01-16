class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :current_teacher
  before_action :login_required

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def current_teacher
      @current_teacher ||= @current_user if current_user.admin?
  end

  def login_required
    redirect_to login_url unless current_user 
  end



end
