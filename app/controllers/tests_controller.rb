class TestsController < ApplicationController
  # before_action :set_student, exept: :index

  def index

  end

  def word_king_menu
    @teacher = Teacher.find(params[:teacher_id]) || Student.find(params[:student_id]).teacher
    @cardsets = @teacher.cardsets
  end

  def word_king
    if @cardset= Cardset.テスト用[@user.wordability]
      @words = @cardset.words
      @words_shadow = @words
      @other_words = Word.where.not(id: @words.ids)
    else
      render :no_test
    end
  end

  def success_or_fail
    score = params[:score].to_f
    if score > 0.8
      @user.update_attribute(:wordability, @user.wordability + 1)
    end
  end



  private

  def word_test_params
    params.require(:word_test).permit(:name, words_attributes: [:name, :meaning, :destroy]).merge(user_id: current_user.id)
  end

  def set_student
    @student = Student.find(params[:student_id])
  end

end
