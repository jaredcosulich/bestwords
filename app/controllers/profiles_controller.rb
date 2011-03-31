class ProfilesController < ApplicationController
  def show
    if params[:id] == "sample_the_dog"
      @user = User::SAMPLE_USER
      @my_words = params.include?(:words) ? params[:words].split(",").map(&:strip).collect { |w| Word.new(:word => w) } : []
      @words = Word::SAMPLE_WORDS + @my_words
    else
      @user = User.find_by_slug(params[:id], :include => :words)

      if @user.nil?
        redirect_to '/' and return
      end

      @words = @user.words
      @my_words = @words.select { |w| w.ip == request.remote_ip}
    end
    
    @owner = current_user == @user
    @suggested_words = @user.suggested_words
  end
end
