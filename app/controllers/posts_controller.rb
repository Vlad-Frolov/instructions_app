class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  # before_action :authenticate_user!, except: [:index, :show]
  # skip_authorize_resource :only => :new
  # before_action :redirect_if_not_signed_in, only: [:new]

    def show
      
        @steps = @post.steps.paginate(:per_page => 1, :page => params[:page])
        @comments = @post.comments.includes(:user).order(created_at: :desc)
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
      authorize! :index, Post

    end

    def edit
      @categories = Category.all
      @step = Step.new
      @steps = @post.steps.order("position")
      authorize! :update, @post
    end

    def destroy
      authorize! :destroy, @post
      @post = Post.find(params[:id]).destroy
      if @post.destroy
        redirect_to posts_path, success:  "#{t(".success_destroy")}"
      end
    end 

    def get_posts
      
      # # search = params[:search]
      category = params[:category]
      tag = params[:tag]
      if params[:val]
        @posts = Post.search(params[:val])
      elsif tag.present?
        @posts = Post.tagged_with(tag)
      elsif category.present?
        @posts = Post.by_category(category)
      else
        @posts = Post.all
      end
    end

    def new
        @categories = Category.all
        @post = Post.new
        authorize! :create, @post
    end

    def create
      
      @post = Post.new(post_params)
      authorize! :create, @post
      respond_to do |format|
        if @post.save 
          format.html { redirect_to @post, notice: 'Post was successfully created.' }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render :edit }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      authorize! :update, @post
      respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to @post, notice: 'Post was successfully updated.' }
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
      params.require(:post).permit(:content, :title, :img_url, :category_id, :tag_list)
                           .merge(user_id: current_user.id)
    end
end
