class TestsController < ApplicationController
  before_action :set_user 

  def word_king
    if @cardset= Cardset.テスト用[@user.wordability]
      @words = []
      while @words.length < 30 do 
        word = @cardset.words[rand(0...@cardset.words.length)]
        unless @words.include?(word)
          @words << word
        end
      end 
      @words_shaddow = @words
      @other_words = @cardset.words.to_ary.difference(@words)
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

  def set_user
    @user = User.find(params[:user_id])
  end

end
