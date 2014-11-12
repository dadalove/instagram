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
      flash[:alert] = "請先登入"
      redirect_to root_path
    end
  end

  def unlike
    @photo = Photo.find(params[:id])
    
    if @like.can_delete_by?(current_user)
      @like.destroy
    end

    redirect_to root_path
  end

  
  def subscription
    @photo = Photo.find(params[:id])

    @subscription = @photo.subscriptions.build

    if @subscription.user = current_user
      @subscription.save
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  

  



end
