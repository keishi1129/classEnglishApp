class ClassroomsController < ApplicationController
  before_action :set_classroom, only: [:show, :edit, :update]
  
  def index
    redirect_to new_group_path unless current_teacher.classrooms.present?
    @classrooms = current_teacher.classrooms
  end

  # def before_user_create
  #   redirect_to new_group_path unless current_teacher.groups.present?
  #   @groups = current_teacher.groups
  # end
  
  # def before_user_list
  #   redirect_to new_group_path unless current_teacher.groups.present?
  #   @groups = current_teacher.groups
  # end

  def new
    @classroom = Classroom.new
  end

  def create
    @classroom = Classroom.new(classroom_params)
    if @classroom.save
      redirect_to classroom_path(@classroom), notice: '教室を作成しました'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @classroom.update(classroom_params)
      redirect_to group_messages_path(@group), notice: 'グループを編集しました'
    else
      render :edit
    end
  end

  def show
    @students = @classroom.students
  end

  private

  def classroom_params
    params.require(:classroom).permit(:name, :password).merge(teacher_id: current_teacher.id)
  end

  def set_classroom
    @classroom = Classroom.find(params[:id])
  end

end

