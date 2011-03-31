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
    if params[:profile_id] == "sample_the_dog"
      redirect_to(profile_path("sample_the_dog", :words => params[:words]))
      return false
    end
    
    @user = User.find_by_slug(params[:profile_id])
    if @user.nil?
      redirect_to '/'
      return false
    end
  end

end
