class TeachersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :set_teacher, only: [:edit, :update, :destroy, :mypage]
  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(teacher_params)
    if @teacher.save
      redirect_to root_url      
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def mypage
  end


  private

  def set_teacher
    id = params[:id] || params[:teacher_id]
    @teacher = Teacher.find(id)
  end

  def teacher_params
    params.require(:teacher).permit(:name, :email, :password, :password_confirmation)
  end
end
