class CommentsController < ApplicationController
    def upvote 
        @comment = Comment.find(params[:id])
        @comment.upvote_by current_user
      end  
      
      def downvote
        @comment = Comment.find(params[:id])
        @comment.downvote_by current_user
      end
end
