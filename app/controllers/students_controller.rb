class StudentsController < ApplicationController
  before_action :set_student, only: [:edit, :update, :destroy]
  before_action :set_classroom, only: [:index, :new, :create]

  def index
    @students = @classroom.students
  end  
  
  def mypage
    @student = current_student 
  end

  def new
    @teacher = @classroom.teacher
    @student = @classroom.students.new
  end

  def create
    @student = @classroom.students.new(student_params)
    if @student.save
      @classroom.students << @student
      redirect_to classroom_path(@classroom), notice: "ユーザー「#{@student.name}」を登録しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @student.update(student_params)
      redirect_to classroom_students_path(@student.classroom), noice: "ユーザー「#{@student.name}」を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @student.destroy
    redirect_to classroom_students_path(@student.classroom), notice: "ユーザー「#{@student.name}」を削除しました。"
  end



  private

  def student_params
    params.require(:student).permit(:name, :email, :password, :password_confirmation)
  end

  def set_student
    @student = Student.find(params[:id])
  end

  def set_classroom
    id = params[:classroom_id] || params[:id]
    @classroom = Classroom.find(id)
  end

end
