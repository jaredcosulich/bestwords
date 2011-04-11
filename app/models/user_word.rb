class UserWord < ActiveRecord::Base
  belongs_to :user
  belongs_to :word

  SAMPLE_WORDS = [
    UserWord.new(:word => Word.find_by_word("cute"), :ip => "ip1", :signature => "Fido", :good => true, :created_at => 5.hours.ago),
    UserWord.new(:word => Word.find_by_word("adorable"), :ip => "ip1", :signature => "Fido", :good => true, :created_at => 5.hours.ago),
    UserWord.new(:word => Word.find_by_word("outdoorsy"), :ip => "ip1", :signature => "Fido", :good => true, :created_at => 5.hours.ago),
    UserWord.new(:word => Word.find_by_word("adventurous"), :ip => "ip1", :signature => "Fido", :good => true, :created_at => 5.hours.ago),
    UserWord.new(:word => Word.find_by_word("fun"), :ip => "ip2", :signature => "Muffy", :good => true, :created_at => 3.hours.ago),
    UserWord.new(:word => Word.find_by_word("adorable"), :ip => "ip2", :signature => "Muffy", :good => true, :created_at => 3.hours.ago),
    UserWord.new(:word => Word.find_by_word("adventurous"), :ip => "ip2", :signature => "Muffy", :good => true, :created_at => 3.hours.ago),
    UserWord.new(:word => Word.find_by_word("cute"), :ip => "ip3", :signature => "Rufus", :good => true, :created_at => 2.hours.ago),
    UserWord.new(:word => Word.find_by_word("fun"), :ip => "ip3", :signature => "Rufus", :good => true, :created_at => 2.hours.ago),
    UserWord.new(:word => Word.find_by_word("loving"), :ip => "ip3", :signature => "Rufus", :good => true, :created_at => 2.hours.ago),
    UserWord.new(:word => Word.find_by_word("adorable"), :ip => "ip4", :signature => "Buster", :good => true, :created_at => 30.minutes.ago),
    UserWord.new(:word => Word.find_by_word("cute"), :ip => "ip4", :signature => "Buster", :good => true, :created_at => 30.minutes.ago),
    UserWord.new(:word => Word.find_by_word("adorable"), :ip => "ip4", :signature => "Buster", :good => true, :created_at => 30.minutes.ago),
    UserWord.new(:word => Word.find_by_word("spunky"), :ip => "ip4", :signature => "Buster", :good => true, :created_at => 30.minutes.ago),

    UserWord.new(:word => Word.find_by_word("evil"), :ip => "ip1", :signature => "Fido", :good => false, :created_at => 5.hours.ago),
    UserWord.new(:word => Word.find_by_word("mean"), :ip => "ip1", :signature => "Fido", :good => false, :created_at => 5.hours.ago),
    UserWord.new(:word => Word.find_by_word("big"), :ip => "ip1", :signature => "Fido", :good => false, :created_at => 5.hours.ago),
    UserWord.new(:word => Word.find_by_word("bad"), :ip => "ip1", :signature => "Fido", :good => false, :created_at => 5.hours.ago),
    UserWord.new(:word => Word.find_by_word("bad"), :ip => "ip2", :signature => "Muffy", :good => false, :created_at => 3.hours.ago),
    UserWord.new(:word => Word.find_by_word("mean"), :ip => "ip2", :signature => "Muffy", :good => false, :created_at => 3.hours.ago),
    UserWord.new(:word => Word.find_by_word("evil"), :ip => "ip3", :signature => "Rufus", :good => false, :created_at => 2.hours.ago),
    UserWord.new(:word => Word.find_by_word("ugly"), :ip => "ip3", :signature => "Rufus", :good => false, :created_at => 2.hours.ago),
    UserWord.new(:word => Word.find_by_word("dumb"), :ip => "ip3", :signature => "Rufus", :good => false, :created_at => 2.hours.ago),
    UserWord.new(:word => Word.find_by_word("mean"), :ip => "ip3", :signature => "Rufus", :good => false, :created_at => 2.hours.ago),
    UserWord.new(:word => Word.find_by_word("mean"), :ip => "ip4", :signature => "Buster", :good => false, :created_at => 30.minutes.ago),
    UserWord.new(:word => Word.find_by_word("evil"), :ip => "ip4", :signature => "Buster", :good => false, :created_at => 30.minutes.ago),
    UserWord.new(:word => Word.find_by_word("dangerous"), :ip => "ip4", :signature => "Buster", :good => false, :created_at => 30.minutes.ago),
    UserWord.new(:word => Word.find_by_word("bad"), :ip => "ip4", :signature => "Buster", :good => false, :created_at => 30.minutes.ago)
  ] rescue nil

  def self.manage_all_words(user, identifier, good_word_params, bad_word_params, signature)
    new_words = UserWord.manage_words(user, identifier, good_word_params, true, signature)
    new_words += UserWord.manage_words(user, identifier, bad_word_params, false, signature)
    Emailing.deliver("notify_words_added", user.id, new_words.map(&:id), signature) unless new_words.blank? || signature == "self"
  end

  def self.manage_words(user, identifier, words_param, good, signature)
    words = words_param.split(',').map(&:strip).map(&:downcase)
    existing_words = user.user_words.select { |uw| uw.good == good && uw.ip == identifier }
    new_words = []
    words.each do |w|
      next if w.blank?
      if (existing_word = existing_words.detect { |ew| ew.smart_word == w }).present?
        existing_words.delete(existing_word)
      else
        standard_word = Word.find_by_word(w)
        custom_word = (standard_word.nil? ? w : nil)
        new_words << user.user_words.create(:word => standard_word, :custom_word => custom_word, :ip => identifier, :good => good, :signature => signature)
      end
    end
    existing_words.map(&:destroy)
    new_words
  end

  def smart_word
    word.present? ? word.word : custom_word
  end

  def smart_signature
    (signature.blank? || signature == "self") ? "Someone" : signature
  end

end
