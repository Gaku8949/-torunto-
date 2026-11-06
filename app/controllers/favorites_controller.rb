class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @photo = Photo.find(params[:photo_id])
    @favorite = @photo.favorites.find_or_initialize_by(user: current_user)

    @favorite.save

    redirect_to @photo
  end

  def destroy
    @photo = Photo.find(params[:photo_id])
    @favorite = @photo.favorites.find_by(user: current_user)

    @favorite&.destroy

    redirect_to @photo
  end
end