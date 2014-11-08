class WelcomeController < ApplicationController
  def index
    # @photos = Photo.all
    @photos = Photo.order("id DESC").page(params[:page]).per(15)
  end

  def like
    @photo = Photo.find(params[:id])
    
    @like = @photo.likes.build

    if @like.user = current_user
      @like.save
      redirect_to root_path
    else
      redirect_to root_path
    end
  end




  



end
