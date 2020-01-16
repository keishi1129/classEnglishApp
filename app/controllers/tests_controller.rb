class TestsController < ApplicationController


  def word_test_index
    @word_tests = Word_test.all
  end

  def word_test_new
    @word_test = Word_test.new
    100.times{@word_test.words.build}
  end

  def word_test_create
    @@word_test = Word_test.new(word_test_params)
  end

  def word_king

  end


  private

  def word_test_params
    params.require(:word_test).permit(:name, words_attributes: [:name, :meaning, :destroy]).merge(user_id: current_user.id)
  end

end
