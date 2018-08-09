class PostsController < ApplicationController
    def show
        @post = Post.find(params[:id])
    end
    def categories
        @categories = Category.all
        @posts = get_posts.paginate(page: params[:page])
    end
    def get_posts
        Post.limit(30)
    end

    private


    
end
