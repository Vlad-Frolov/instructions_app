class PostsController < ApplicationController

    def show
        @post = Post.find(params[:id])
    end
        
    def crafts
        posts_for_branch(params[:action])
      end
    
      def get_posts(params)
        @posts = Post.where(id: params)
      end
      
      private

      def posts_for_branch(name)
        @cat = Category.where(name: name)
        @posts = @cat.posts.limit
    end


    
end
