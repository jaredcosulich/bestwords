class Word < ActiveRecord::Base
  belongs_to :user

  SAMPLE_WORDS = (0...49).collect { Word.new(:word => "cute") } +
                 (0...38).collect { Word.new(:word => "best-friend") } +
                 (0...34).collect { Word.new(:word => "fun") } +
                 (0...29).collect { Word.new(:word => "energetic") } +
                 (0...26).collect { Word.new(:word => "cuddly") } +
                 (0...19).collect { Word.new(:word => "good at tricks") } +
                 (0...15).collect { Word.new(:word => "adorable") }
end
