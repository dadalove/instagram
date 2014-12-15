class PhotosController < ApplicationController
  
  before_filter :authenticate_user!

  def index
    @photos = Photo.all
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

    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def unlike
    @photo = Photo.find(params[:id])
    
    @like = @photo.find_like_by_user(current_user)

    @like.destroy if @like

    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
  
  # def subscription
  #   @photo = Photo.find(params[:id])

  #   if @photo.can_user_subscription?(current_user)
  #     @subscription = @photo.subscriptions.build
  #     @subscription.user = current_user
  #     @subscription.save!
  #   end

  #   redirect_to :back
  # end

  # def unsubscription
  #   @photo = Photo.find(params[:id])

  #   @subscription = @photo.find_subscription_by_user(current_user)

  #   @subscription.destroy if @subscription

  #   redirect_to root_path
  # end

  private

  def photo_params 
    params.require(:photo).permit(:content, :avatar, :user_id, :all_tags)
  end

end
