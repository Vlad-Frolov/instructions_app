class CommentsController < ApplicationController

  def upvote
    @comment = Comment.find(params[:id])
    @comment.upvote_by current_user
    update_count(@comment)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def downvote
    @comment = Comment.find(params[:id])
    @comment.downvote_by current_user
    update_count(@comment)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  private

  def update_count(comment)
    comment.likes = comment.get_upvotes.size
    comment.dislikes = comment.get_downvotes.size
    comment.save
  end


end
