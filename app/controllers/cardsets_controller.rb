class CardsetsController < ApplicationController
  before_action :set_cardset, only: [:show, :edit, :update, :destroy, :practice, :word_find, :test]

  # GET /words
  # GET /words.json
  def index
    @cardsets = Cardset.練習用.all
    @cardsets_test = Cardset.テスト用.all
  end

  def test_index
    @cardsets_test = Cardset.テスト用.all
  end

  # GET /words/1
  # GET /words/1.json
  def show
  end

  # GET /words/new
  def new
    @cardset = Cardset.new
    30.times{@cardset.words.build}
  end

  # GET /words/1/edit
  def edit
    (30 - @cardset.words.length).times{@cardset.words.build}
  end

  # POST /words
  # POST /words.json
  def create
    @cardset = Cardset.new(cardset_params)
    if @cardset.save
      redirect_to user_cardsets_path
    else
      30.times{@cardset.words.build}
      render :new
    end
  end

  # PATCH/PUT /words/1
  # PATCH/PUT /words/1.json
  def update
    @cardset.update(cardset_params)
    if @cardset.save
      redirect_to user_cardsets_url
    else
      (30 - @cardset.words.length).times{@cardset.words.build}
      render :edit
    end
  end

  # DELETE /words/1
  # DELETE /words/1.json
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
    @user = User.find(params[:user_id])
    duplicated_cardset = @cardset.duplicate
    @words = duplicated_cardset.words
    unless @user.duplicated_cardsets.include?(DuplicatedCardset.find_by(user_id: @user.id, origin_id: @cardset.id))
      @user.duplicated_cardsets << duplicated_cardset
    end
    @cardsets = Cardset.other_origin_cardsets(@user.duplicated_cardsets)
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
    @words_shaddow = @cardset.words
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
      params.fetch(:cardset, {}).permit(:name, :use, words_attributes: [:name, :meaning, :_destroy, :id]).merge(user_id: current_user.id)
    end
end
