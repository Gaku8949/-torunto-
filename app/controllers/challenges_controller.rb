class ChallengesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_challenge, only: [:show, :edit, :update, :destroy]
  before_action :authorize_challenge_owner!, only: [:edit, :update, :destroy]

  def index
    @challenges = Challenge.order(created_at: :desc).page(params[:page]).per(6)
  end

  def new
    @photo = Photo.find(params[:photo_id])
    @challenge = @photo.challenges.build
    @challenge.build_shooting_setting
    @techniques = Technique.all
  end

  def create
    @photo = Photo.find(params[:photo_id])

    @challenge = @photo.challenges.build(challenge_params)
    @challenge.user = current_user

    if @challenge.save
      redirect_to @photo, notice: "撮影チャレンジを投稿しました"
    else
      @techniques = Technique.all
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @photo = @challenge.reference_photo
  end

  def edit
    @photo = @challenge.reference_photo
    @techniques = Technique.all
  end

  def update
    if @challenge.demo_sample?
      redirect_to @challenge, alert: "このチャレンジはデモ用サンプルのため保存・削除できません"
      return
    end

    if @challenge.update(challenge_params)
      redirect_to challenges_path, notice: "撮影チャレンジを更新しました"
    else
      @photo = @challenge.reference_photo
      @techniques = Technique.all
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @challenge.demo_sample?
      redirect_to @challenge, alert: "このチャレンジはデモ用サンプルのため保存・削除できません"
      return
    end

    @challenge.destroy
    redirect_to challenges_path, notice: "撮影チャレンジを削除しました", status: :see_other
  end

  private

  def set_challenge
    @challenge = Challenge.find(params[:id])
  end

  def authorize_challenge_owner!
    unless @challenge.user == current_user
      redirect_to challenges_path, alert: "このチャレンジを編集・削除する権限がありません"
    end
  end

  def challenge_params
    params.require(:challenge).permit(
      :image,
      :title,
      :location,
      :comment,
      technique_ids: [],
      shooting_setting_attributes: [
        :aperture,
        :iso,
        :shutter_speed,
        :focal_length
      ]
    )
  end
end