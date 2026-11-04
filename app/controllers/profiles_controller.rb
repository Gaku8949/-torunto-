class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @photos = current_user.photos
                          .order(created_at: :desc)
                          .page(params[:photos_page])
                          .per(6)

    @photo_count = current_user.favorites.count
    @challenges = current_user.challenges
                              .order(created_at: :desc)
                              .page(params[:challenges_page])
                              .per(6)
    @challenge_count = current_user.challenges.count
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(profile_params)
      redirect_to profile_path, notice: "プロフィールを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:user).permit(:username, :email, :avatar)
  end
end
