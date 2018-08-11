class PostsController < ApplicationController
    def show
        @post = Post.find(params[:id])
    end
        
    def index
      @posts = get_posts.paginate(page: params[:page])
      @categories = Category.all
    end

    def get_posts
      Post.limit(20)
    end

    def new
      @categories = Category.all
      @post = Post.new
    end

    def create
      @post = Post.new(post_params)
      if @post.save 
        redirect_to post_path(@post) 
      else
        redirect_to root_path
      end
    end

    def post_params
      params.require(:post).permit(:content, :title, :category_id)
                           .merge(user_id: current_user.id)
    end
end
