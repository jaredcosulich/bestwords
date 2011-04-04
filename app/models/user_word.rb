class UserWord < ActiveRecord::Base
  belongs_to :user
  belongs_to :word

  SAMPLE_BEST_WORDS = (0...49).collect { UserWord.new(:word => Word.find_by_word("cute")) } +
                 (0...34).collect { UserWord.new(:word => Word.find_by_word("fun")) } +
                 (0...29).collect { UserWord.new(:word => Word.find_by_word("energetic")) } +
                 (0...26).collect { UserWord.new(:word => Word.find_by_word("cuddly")) } +
                 (0...19).collect { UserWord.new(:word => Word.find_by_word("adventurous")) } +
                 (0...18).collect { UserWord.new(:word => Word.find_by_word("adorable")) } +
                 (0...15).collect { UserWord.new(:word => Word.find_by_word("outdoorsy")) } +
                 (0...14).collect { UserWord.new(:word => Word.find_by_word("small")) } rescue nil

  SAMPLE_WORST_WORDS = (0...61).collect { UserWord.new(:word => Word.find_by_word("ugly")) } +
                 (0...42).collect { UserWord.new(:word => Word.find_by_word("well-behaved")) } +
                 (0...36).collect { UserWord.new(:word => Word.find_by_word("evil")) } +
                 (0...33).collect { UserWord.new(:word => Word.find_by_word("mean")) } +
                 (0...26).collect { UserWord.new(:word => Word.find_by_word("arrogant")) } +
                 (0...15).collect { UserWord.new(:word => Word.find_by_word("anal")) } +
                 (0...9).collect { UserWord.new(:word => Word.find_by_word("angry")) } rescue nil

  def self.manage_words(user, ip, words_param, good)
    words = words_param.split(',').map(&:strip).map(&:downcase)
    existing_words = user.user_words.select { |uw| uw.good == good && uw.ip == ip }
    new_words = []
    words.each do |w|
      next if w.blank?
      if (existing_word = existing_words.detect { |ew| ew.smart_word == w }).present?
        existing_words.delete(existing_word)
      else
        standard_word = Word.find_by_word(w)
        custom_word = (standard_word.nil? ? w : nil)
        new_words << user.user_words.create(:word => standard_word, :custom_word => custom_word, :ip => ip, :good => good)
      end
    end
    existing_words.map(&:destroy)
    Emailing.deliver("notify_words_added", user.id, new_words.map(&:id))
  end

  def smart_word
    word.present? ? word.word : custom_word
  end

end
