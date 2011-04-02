class UserWord < ActiveRecord::Base
  belongs_to :user
  belongs_to :word

  SAMPLE_BEST_WORDS = (0...49).collect { UserWord.new(:word => Word.find_by_word("cute")) } +
                 (0...34).collect { Word.new(:word => Word.find_by_word("fun")) } +
                 (0...29).collect { Word.new(:word => Word.find_by_word("energetic")) } +
                 (0...26).collect { Word.new(:word => Word.find_by_word("cuddly")) } +
                 (0...19).collect { Word.new(:word => Word.find_by_word("adventurous")) } +
                 (0...18).collect { Word.new(:word => Word.find_by_word("adorable")) } +
                 (0...15).collect { Word.new(:word => Word.find_by_word("outdoorsy")) } +
                 (0...14).collect { Word.new(:word => Word.find_by_word("small")) }

  SAMPLE_WORST_WORDS = (0...61).collect { Word.new(:word => Word.find_by_word("ugly")) } +
                 (0...42).collect { Word.new(:word => Word.find_by_word("well-behaved")) } +
                 (0...36).collect { Word.new(:word => Word.find_by_word("evil")) } +
                 (0...33).collect { Word.new(:word => Word.find_by_word("mean")) } +
                 (0...26).collect { Word.new(:word => Word.find_by_word("arrogant")) } +
                 (0...15).collect { Word.new(:word => Word.find_by_word("anal")) } +
                 (0...9).collect { Word.new(:word => Word.find_by_word("angry")) }

end
