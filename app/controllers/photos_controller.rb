class PhotosController < ApplicationController
  

  def index
    
  end

  def new
    @photo = Photo.new
  end


  def create
    @photo = Photo.new(photo_params)

    @photo.user = current_user

    if @photo.save
      redirect_to root_path
    else
      render :new
    end 
  end




  

  def destroy
    @photo = Photo.find(params[:id])
    
    if @photo.user == current_user
      @ohoto.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end

  end









  private

  def photo_params 
    params.require(:photo).permit(:content, :avatar, :user_id)
  end



end
