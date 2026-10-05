class ChallengesController < ApplicationController
  before_action :authenticate_user!

  def new
    @photo = Photo.find(params[:photo_id])
    @challenge = @photo.challenges.build
  end

  def create
    @photo = Photo.find(params[:photo_id])

    @challenge = @photo.challenges.build(challenge_params)
    @challenge.user = current_user

    if @challenge.save
      redirect_to @photo, notice: "撮影チャレンジを投稿しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @challenge = Challenge.find(params[:id])

    if @challenge.user == current_user
      @challenge.destroy
      redirect_to @challenge.reference_photo, notice: "撮影チャレンジを削除しました"
    else
      redirect_to @challenge.reference_photo, alert: "このチャレンジを削除する権限がありません"
    end
  end
  
  private

  def challenge_params
    params.require(:challenge).permit(:image, :comment)
  end
end
