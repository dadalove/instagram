class PhotosController < ApplicationController
  def index
    
  end

  def new
    @photo = Photo.new
  end


  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      redirect_to root_path
    else
      render :new
    end 
  end




  

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to root_path
  end









  private

  def photo_params 
    params.require(:photo).permit(:content, :avatar, :user_id)
  end



end
