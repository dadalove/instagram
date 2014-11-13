class PhotosController < ApplicationController
  
  before_filter :authenticate_user!

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

  def like
    @photo = Photo.find(params[:id])
    
    if @photo.can_user_like?(current_user)
      @like = @photo.likes.build
      @like.user = current_user
      @like.save!
    end

    redirect_to :back
  end

  def unlike
    @photo = Photo.find(params[:id])
    
    @like = @photo.find_like_by_user(current_user)

    @like.destroy if @like

    redirect_to root_path
  end

  
  def subscription
    @photo = Photo.find(params[:id])

    @subscription = @photo.subscriptions.build

    if @subscription.user = current_user
      @subscription.save
      redirect_to root_path
    else
      flash[:alert] = "請先登入"
      redirect_to root_path
    end
  end

  private

  def photo_params 
    params.require(:photo).permit(:content, :avatar, :user_id)
  end

end
