class Word < ActiveRecord::Base
  after_create :assign_user_words

  def assign_user_words
    UserWord.where("word_id is null").where("custom_word = ?", word).each do |user_word|
      user_word.update_attributes(:word_id => id)
    end
  end

end
