class SessionsController < ApplicationController
  skip_before_action :login_required

  def new
  end

  def create
    student = Student.find_by(email: session_params[:email])

    if student&.authenticate(session_params[:password])
      session[:student_id]= student.id
      redirect_to root_url, notice: 'ログインしました'
    else
      render :new
    end
  end

  def teacher_new
  end

  def teacher_create
    teacher = Teacher.find_by(email: session_params[:email])
    if teacher&.authenticate(session_params[:password])
      session[:teacher_id]= teacher.id
      redirect_to root_url, notice: 'ログインしました'
    else
      render :teacher_new
    end
  end

  def destroy
    reset_session
    redirect_to root_url, notice: 'ログアウトしました'
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
