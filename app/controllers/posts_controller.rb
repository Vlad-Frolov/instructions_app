class PostsController < ApplicationController
    def show
        @post = Post.find(params[:id])
    end
        
    def index
      @posts = get_posts.paginate(page: params[:page])
      @categories = Category.all
      respond_to do |format|
        format.html
        format.js { render partial: 'posts/posts_pagination_page' }
      end
    end

    def get_posts
      
      search = params[:search]
      category = params[:category]

      if category.blank? && search.blank?
        posts = Post.all
      elsif category.blank? && search.present?
        posts = Post.search(search)
      elsif category.present? && search.blank?
        posts = Post.by_category(category)
      elsif category.present? && search.present?
        posts = Post.by_category(category).search(search)
      else
      end
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
      params.require(:post).permit(:content, :title, :img_url, :category_id)
                           .merge(user_id: current_user.id)
    end
end
