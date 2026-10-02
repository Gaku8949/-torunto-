class PhotosController < ApplicationController
   def index
    @photos = Photo.all
   end

   def new
    @photo = Photo.new
    @photo.build_shooting_setting
   end
   
   def create
     @photo = current_user.photos.build(photo_params)

     if @photo.save
        redirect_to @photo, notice: "写真を投稿しました"
     else
        render :new, status: :unprocessable_entity
     end
   end

   def show
    @photo = Photo.find(params[:id])
   end

   def edit
    @photo = Photo.find(params[:id])
   end

   def update
     @photo = Photo.find(params[:id])

     if @photo.update(photo_params)
       redirect_to @photo, notice: "写真を更新しました"
     else

       render :edit, status: :unprocessable_entity
     end
   end

   private
        
   def photo_params
    params.require(:photo).permit(
        :image,
        :title,
        :description,
        :location,
        shooting_setting_attributes: [
          :aperture,
          :iso,
          :shutter_speed,
          :focal_length
        ]
    )
   end
end
