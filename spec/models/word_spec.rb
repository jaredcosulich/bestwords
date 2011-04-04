require 'spec_helper'

describe Word do
  context "after create" do
    describe ".assign_user_words" do
      it "should assign this word to user words with the same custom word" do
        uw = UserWord.create(:custom_word => "hipster")
        uw.word.should be_nil
        uw.custom_word.should == "hipster"

        word = Word.create(:word => "hipster")
        uw.reload.word.should == word
      end
    end
  end
end
