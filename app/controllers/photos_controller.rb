class PhotosController < ApplicationController
  
    # before_filter :authenticate_user!, only:[:show]

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
      flash[:alert] = "請新增照片和描述"
      render :new
    end 
  end

  
  def show
    @photo = Photo.find(params[:id])
    @like = @photo.likes.build
    @photos = Photo.all
  end

  

  def destroy
    @photo = Photo.find(params[:id])
    
    if @photo.user == current_user
      @photo.destroy
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
