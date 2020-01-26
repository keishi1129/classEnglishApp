class CardsetsController < ApplicationController
  before_action :set_cardset, only: [:show, :edit, :update, :destroy, :practice, :word_find, :test]


  def index
    @cardsets = Cardset.練習用.all
    @cardsets_test = Cardset.テスト用.all
  end

  def test_index
    @cardsets_test = Cardset.テスト用.all
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
    if @cardset.save
      redirect_to cardsets_path
    else
      30.times{@cardset.words.build}
      render :new
    end
  end

 
  def update
    @cardset.update(cardset_params)
    if @cardset.save
      redirect_to cardsets_url
    else
      (30 - @cardset.words.length).times{@cardset.words.build}
      render :edit
    end
  end


  def destroy
    if @cardset.練習用?
      @cardset.destroy
      redirect_to user_cardsets_url
    else
      @cardset.destroy
      redirect_to test_index_user_cardsets_url
    end
  end

  def practice
    @student = Student.find(params[:student_id])
    duplicated_cardset = @cardset.duplicate
    @words = duplicated_cardset.words
    unless @student.duplicated_cardsets.include?(DuplicatedCardset.find_by(student_id: @student.id, origin_id: @cardset.id))
      @student.duplicated_cardsets << duplicated_cardset
    end
    @cardsets = Cardset.other_origin_cardsets(@student.duplicated_cardsets)
  end

  def word_find
    index = params[:index].to_i - 1
    if index < @cardset.words.length && index >= 0
      @word = @cardset.words[index]
    else
      return false
    end
    respond_to do |format| 
      format.json
    end
  end

  def test
    @words = @cardset.words
    @words_shadow = @cardset.words
    @length = @cardset.words.length - 1
  end

  def find_words_name
    @words = Word.where('name LIKE ?', "#{params[:keyword]}%").limit(3)
    respond_to do |format| 
      format.json
    end
  end

  def find_words_definition
    @words = Word.where('meaning LIKE ?', "#{params[:keyword]}%").limit(3)
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
        params.fetch(:cardset, {}).permit(:name, :use, words_attributes: [:name, :meaning, :_destroy, :id]).merge(student_id: current_student.id)
      else 
        params.fetch(:cardset, {}).permit(:name, :use, words_attributes: [:name, :meaning, :_destroy, :id]).merge(teacher_id: current_teacher.id)
      end
    end
end
