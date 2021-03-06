class CardsetsController < ApplicationController
  before_action :set_cardset, only: [:show, :edit, :update, :destroy, :practice, :word_find, :test, :word_king, :word_score]


  def index
    classroom = current_student.classroom 
    @cardsets = classroom.cardsets.all
  end

  def test_index
    @teacher = Teacher.find(params[:teacher_id])
    @cardsets_test = @teacher.cardsets.テスト用.all
  end

  def show
  end

  def new
    @cardset = Cardset.new
    30.times{@cardset.words.build}
  end


  def edit
    (30 - @cardset.words.length).times{@cardset.words.build}
  end

  
  def create
    @cardset = Cardset.new(cardset_params)
    if @cardset.練習用? && @cardset.save
      redirect_to cardsets_path
    elsif @cardset.save
      redirect_to test_index_teacher_cardsets_path(@cardset.teacher)
    else
      30.times{@cardset.words.build}
      render :new
    end
  end

 
  def update
    @cardset.update(cardset_params)
    if @cardset.練習用? && @cardset.save
      redirect_to cardsets_url
    elsif @cardset.save
      redirect_to test_index_teacher_cardsets_path(@cardset.teacher)
    else
      (30 - @cardset.words.length).times{@cardset.words.build}
      render :edit
    end
  end


  def destroy
    if @cardset.練習用?
      @cardset.destroy
      redirect_to cardsets_url
    else
      @cardset.destroy
      redirect_to test_index_teacher_cardsets_path(@cardset.teacher)
    end
  end

  def practice
    @student = Student.find(params[:student_id])
    duplicated_cardset = @cardset.duplicate
    @words = duplicated_cardset.words
    unless @student.duplicated_cardsets.include?(DuplicatedCardset.find_by(student_id: @student.id, origin_id: @cardset.id))
      @student.duplicated_cardsets << duplicated_cardset
    end
    @cardsets = Cardset.where(classroom_id: @student.classroom.id).other_origin_cardsets(@student.duplicated_cardsets)
  end

  def word_find
    index = params[:index].to_i - 1
    return false if index > @cardset.words.length || index < 0
    @word = @cardset.words[index]
    respond_to do |format| 
      format.json
    end
  end

  def test
    @words = @cardset.words
    @words_shadow = @cardset.words
    @length = @cardset.words.length - 1
  end


  def word_king_menu
    @teacher = Teacher.find(params[:teacher_id]) || Student.find(params[:student_id]).teacher
    @cardsets = @teacher.cardsets.テスト用
  end

  def word_king
    @words = @cardset.words
    @words_shadow = @cardset.words
    @length = @cardset.words.length - 1
  end

  def word_score
    score = params[:score].to_i + current_student.vocabulary
    current_student.update_attributes(vocabulary: score)
  end


  def find_words_name
    @words = Word.where('name LIKE ?', "#{params[:keyword]}%").group(:name).limit(3)
    respond_to do |format| 
      format.json
    end
  end

  def find_words_definition
    @words = Word.where('meaning LIKE ?', "#{params[:keyword]}%").group(:meaning).limit(3)
    respond_to do |format| 
      format.json
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cardset
      id = params[:id] || params[:cardset_id]
      @cardset = Cardset.find(id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def word_params
      params.fetch(:word, {})
    end

    def cardset_params
      if current_student
        params.fetch(:cardset, {}).permit(:name, :use, words_attributes: [:name, :meaning, :_destroy, :id]).merge(student_id: current_student.id, classroom_id: current_student.classroom.id)
      else 
        params.fetch(:cardset, {}).permit(:name, words_attributes: [:name, :meaning, :_destroy, :id]).merge(teacher_id: current_teacher.id, use: 2)
      end
    end
end
