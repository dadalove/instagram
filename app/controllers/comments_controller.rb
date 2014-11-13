class CommentsController < ApplicationController

  before_action :authenticate_user!
  
  def create
    @comment = Comment.new(comment_params)
    
    if @comment.user = current_user 
      @comment.save
      redirect_to root_path
    else
      redirect_to root_path
    end  
  end

  def destroy
    @comment = Comment.find(params[:id])
    
    if @comment.user == current_user
      @comment.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :photo_id, :user_id)
  end

end
