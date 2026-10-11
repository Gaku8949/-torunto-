class HomeController < ApplicationController
  def landing
  end
  
  def index
    @photos = Photo.all
  end
end
