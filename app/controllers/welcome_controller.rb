class WelcomeController < ApplicationController
 
  def index
    @photos = Photo.order("id DESC").page(params[:page]).per(15)
  end

end
