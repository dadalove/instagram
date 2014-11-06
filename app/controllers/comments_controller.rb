class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to root_path
    else
      render :new
    end  
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to root_path
  end





  private

  def comment_params
    params.require(:comment).permit(:content, :photo_id, :user_id)
  end


end
