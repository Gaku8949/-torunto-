class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @photo = Photo.find(params[:photo_id])
    @favorite = @photo.favorites.build(user: current_user)

    if@favorite.save
      redirect_to @photo, notice: "お気に入りに追加しました"
    else
      redirect_to @photo, alert: "すでにお気に入り登録されています"
    end
  end

  def destroy
    @photo = Photo.find(params[:photo_id])
    @favorite = @photo.favorites.find_by(user: current_user)

    if @favorite
      @favorite.destroy
      redirect_to @photo, notice: "お気に入りを解除しました"
    else
      redirect_to @photo, alert: "お気に入り登録されていません"
    end
  end
end
