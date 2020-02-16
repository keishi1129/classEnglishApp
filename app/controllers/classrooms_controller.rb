class ClassroomsController < ApplicationController
  before_action :set_teacher, only: [:index, :new, :edit, :update]
  before_action :set_classroom, only: [:show, :edit, :update]
  
  def index
    redirect_to new_teacher_classroom_path unless current_teacher.classrooms.present?
    @classrooms = current_teacher.classrooms
  end

  def new
    @classroom = @teacher.classrooms.new
  end

  def create
    @classroom = Classroom.new(classroom_params)
    if @classroom.save
      current_teacher.classrooms << @classroom
      redirect_to teacher_classrooms_path(current_teacher), notice: '教室を作成しました'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @classroom.update(classroom_params)
      redirect_to classroom_path(@group), notice: 'グループを編集しました'
    else
      render :edit
    end
  end

  def show
    @students = @classroom.students
  end

  private

  def classroom_params
    params.require(:classroom).permit(:name, :classroom_code).merge(teacher_id: current_teacher.id)
  end

  def set_classroom
    @classroom = Classroom.find(params[:id])
  end

  def set_teacher
    @teacher = Teacher.find(params[:teacher_id])
  end

end

