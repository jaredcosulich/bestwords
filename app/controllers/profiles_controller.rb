class ProfilesController < ApplicationController
  def show
    @user = User.find_by_slug(params[:id])

    if @user.nil?
      redirect_to '/'
    end    
  end

  def create
    @user = User.create(params[:user].merge(:email => "tmp#{Time.new.to_i}@example.com", :password => User::FAKE_PASSWORD, :password_confirmation => User::FAKE_PASSWORD))
    redirect_to profile_path(@user)
  end
end
