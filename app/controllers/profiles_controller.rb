class ProfilesController < ApplicationController
  def show
    if params[:id] == "sample_the_dog"
      @user = User::SAMPLE_USER
      @my_good_words = params.include?(:good_words) ? params[:good_words].split(",").map(&:strip).collect { |w| UserWord.new(:word => Word.new(:word => w)) unless w.blank? }.compact : []
      @my_bad_words = params.include?(:bad_words) ? params[:bad_words].split(",").map(&:strip).collect { |w| UserWord.new(:word => Word.new(:word => w)) unless w.blank? }.compact : []
      @good_words = UserWord::SAMPLE_BEST_WORDS + @my_good_words
      @bad_words = UserWord::SAMPLE_WORST_WORDS + @my_bad_words
      @used_words = @good_words + @bad_words
    else
      @user = User.find_by_slug(params[:id], :include => :words)

      if @user.nil?
        redirect_to '/' and return
      end

      @words = @user.words
      @my_words = @words.select { |w| w.ip == request.remote_ip}
    end
    
    @owner = current_user == @user
  end
end
