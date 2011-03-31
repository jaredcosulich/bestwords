class WordsController < ApplicationController
  before_filter :lookup_user

  def create
    words = params[:words].split(',').map(&:strip)
    words.each { |w| @user.words.create(:word => w, :ip => request.remote_ip) }
    redirect_to(profile_path(@user))
  end

  def update

  end

  private
  def lookup_user
    @user = User.find_by_slug(params[:profile_id])
    if @user.nil?
      redirect_to '/'
      return false
    end
  end

end
