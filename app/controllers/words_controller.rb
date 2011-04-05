class WordsController < ApplicationController
  before_filter :lookup_user

  def create
    UserWord.manage_all_words(@user, session_identifier, params[:good_words], params[:bad_words], params[:signature])
    redirect_to(profile_path(@user))
  end

  private
  def lookup_user
    if params[:profile_id] == "sample_the_dog"
      redirect_to(profile_path("sample_the_dog", :good_words => params[:good_words], :bad_words => params[:bad_words], :signature => params[:signature]))
      return false
    end
    
    @user = User.find_by_slug(params[:profile_id])
    if @user.nil?
      redirect_to '/'
      return false
    end
  end

end
