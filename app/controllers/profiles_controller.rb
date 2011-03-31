class ProfilesController < ApplicationController
  def show
    @user = User.find_by_slug(params[:id], :include => :words)

    if @user.nil?
      redirect_to '/'
    end

    @words = @user.words

    @my_words = @words.select { |w| w.ip == request.remote_ip}

    @owner = current_user == @user
    @suggested_words = @user.suggested_words
  end
end
