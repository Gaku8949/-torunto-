class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @photos = current_user.photos
  end
end
