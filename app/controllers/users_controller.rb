class UsersController < ApplicationController
  def create
    @user = User.create(params[:user].merge(:email => "tmp#{Time.new.to_i}@example.com", :password => User::FAKE_PASSWORD, :password_confirmation => User::FAKE_PASSWORD))
    sign_in(@user)
    redirect_to profile_path(@user)
  end

  def update
    @user = User.find_by_slug(params[:id])
    @user.update_attributes(params[:user].delete_if { |k,v| v.blank? })
    raise @user.reload.suggested_words.inspect
    redirect_to(profile_path(@user))
  end

end



