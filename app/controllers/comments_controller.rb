class CommentsController < 

  def create
    @comment = @Comment.new(comment_params)

    if @reply.save
      redirect_to root_path
    else
      render :new
    end  
  end


  




  private

  def comment_params
    params.require(:comment).permit(:content)
  end


end
