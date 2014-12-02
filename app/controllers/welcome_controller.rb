class WelcomeController < ApplicationController
 
  def index
    if params[:tag]
      @photos = Photo.tagged_with(params[:tag]).order("id DESC").page(params[:page]).per(15)
    else
      @photos = Photo.order("id DESC").page(params[:page]).per(15)
    end

  end

end
