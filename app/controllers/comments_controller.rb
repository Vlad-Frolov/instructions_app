class CommentsController < ApplicationController
  def upvote 
    @comment = Comment.find(params[:id])
    @comment.upvote_by current_user
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render layout: false }
    end 
  end  
      
  def downvote
    @comment = Comment.find(params[:id])
    @comment.downvote_by current_user
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render layout: false }
    end 
  end
  
end
