class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: :index
    
    skip_authorize_resource :only => :new
    before_action :redirect_if_not_signed_in, only: [:new]
    def show
        @post = Post.find(params[:id])
        @steps = @post.steps.paginate(:per_page => 1, :page => params[:page])
        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @steps }
          format.js
        end
    end
        
    def index
      @posts = get_posts.paginate(page: params[:page])
      @categories = Category.all
      respond_to do |format|
        format.html
        format.js { render partial: 'posts/posts_pagination_page' }
      end
    end

    def edit
      @step = Step.new
      @steps = @post.steps.order("position")
    end

    def destroy
      @post = Post.find(params[:id]).destroy
      redirect_to posts_path
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

    def update
      respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to edit_post_path(@post.id), notice: 'Post was successfully updated.' }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:content, :title, :img_url, :category_id)
                           .merge(user_id: current_user.id)
    end
end
