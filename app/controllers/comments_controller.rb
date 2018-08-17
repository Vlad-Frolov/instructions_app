class CommentsController < ApplicationController
  before_action :set_post
  
  def create
    @comment = Comment.new(text: params[:comment][:text], post: @post)
    if @comment.save
      redirect_to @post
    else
      render :back
    end

  end



  private 
    def set_post
      @post = Post.find(params[:post_id])
    end

    


end
