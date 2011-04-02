require 'spec_helper'

describe UserWord do

  describe "#manage_words" do
    before :each do
      @user = User.create(:email => "user@example.com", :password => "123456  ")
      %w{big large medium small tiny}.each do |w|
        Word.create(:word => w)
      end
    end

    it "should create new words for a user and a given ip" do
      UserWord.manage_words(@user, "an_ip", "big, medium, small", true)
      @user.reload
      @user.user_words.map(&:word).map(&:word).should =~ %w{big medium small}
      @user.user_words.each { |uw| uw.should be_good }
    end

    it "should set custom words if the words are not standard" do
      UserWord.manage_words(@user, "an_ip", "big, medium, gargantuan", false)
      @user.reload
      @user.user_words.map(&:word).compact.map(&:word).should =~ %w{big medium}
      @user.user_words.map(&:smart_word).should =~ %w{big medium gargantuan}
      @user.user_words.each { |uw| uw.should_not be_good }
    end

    it "should not create a new word for a user and a given ip if the word already exists" do
      @user.user_words.create(:word => Word.find_by_word("big"), :ip => "an_ip")
      UserWord.manage_words(@user, "an_ip", "big, medium", true)
      @user.user_words.map(&:word).map(&:word).should =~ %w{big medium}
    end

    it "should not create a new word for a user and a given ip if the word already exists, but it's in the list twice" do
      @user.user_words.create(:word => Word.find_by_word("big"), :ip => "an_ip")
      UserWord.manage_words(@user, "an_ip", "big, big, medium", true)
      @user.reload.user_words.map(&:word).map(&:word).should =~ %w{big big medium}
    end

    it "should delete words if they are no longer in the list" do
      @user.user_words.create(:word => Word.find_by_word("big"), :ip => "an_ip")
      UserWord.manage_words(@user, "an_ip", "small, medium", true)
      @user.reload.user_words.map(&:word).map(&:word).should =~ %w{small medium}
    end

    it "should handle deleting a dup if user deleted it" do
      @user.user_words.create(:word => Word.find_by_word("small"), :ip => "an_ip")
      @user.user_words.create(:word => Word.find_by_word("big"), :ip => "an_ip")
      @user.user_words.create(:word => Word.find_by_word("big"), :ip => "an_ip")
      UserWord.manage_words(@user, "an_ip", ",small,big, medium", true)
      @user.reload.user_words.map(&:word).map(&:word).should =~ %w{small big medium}
    end

    it "should handle weird comma combinations" do
      UserWord.manage_words(@user, "an_ip", ", , ,,,small, ,, ,medium,   , ,,, ,", true)
      @user.reload.user_words.map(&:word).map(&:word).should =~ %w{small medium}
    end
  end

end
