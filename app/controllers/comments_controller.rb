class CommentsController < ApplicationController
  def upvote 
    @comment = Comment.find(params[:id])
    @comment.like_cout current_user
    respond_to do |format|
      format.html { redirect_to :back }
      format.js 
    end 
  end  
      
  def downvote
    @comment = Comment.find(params[:id])
    @comment.downvote_by current_user
    respond_to do |format|
      format.html { redirect_to :back }
      format.js 
    end 
  end
  
end
