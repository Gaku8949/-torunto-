class PhotosController < ApplicationController
   before_action :authenticate_user!
   before_action :set_photo, only: [:show, :edit, :update, :destroy]
   before_action :authorize_photo_owner!, only: [:edit, :update, :destroy]
  
   def index
    @photos = Photo.order(created_at: :desc).page(params[:page]).per(6)
   end

   def new
    @photo = Photo.new
    @photo.build_shooting_setting
    @techniques = Technique.all
   end
   
   def create
     @photo = current_user.photos.build(photo_params)
     @photo.demo_sample = false

     if @photo.save
        redirect_to @photo, notice: "写真を投稿しました"
     else
        render :new, status: :unprocessable_entity
     end
   end

   def show
   end

   def edit
    @techniques = Technique.all
   end

   def update
     if @photo.demo_sample?
      redirect_to @photo, alert: "この写真はデモ用サンプルのため保存・削除できません"
      return
     end

     if @photo.update(photo_params)
       redirect_to @photo, notice: "写真を更新しました"
     else
       render :edit, status: :unprocessable_entity
     end
   end

   def destroy
     if @photo.demo_sample?
      redirect_to @photo, alert: "この写真はデモ用サンプルのため保存・削除できません"
      return
     end

     @photo.destroy
     redirect_to photos_path, notice: "写真を削除しました", status: :see_other
   end
   
   private

   def set_photo
    @photo = Photo.find(params[:id])
   end

   def authorize_photo_owner!
    unless @photo.user == current_user
      redirect_to @photo, alert: "この写真を編集・削除する権限がありません"
    end
   end

   def photo_params
    params.require(:photo).permit(
        :image,
        :title,
        :description,
        :location,
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
