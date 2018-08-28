class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  # before_action :authenticate_user!, except: [:index, :show]
  # skip_authorize_resource :only => :new
  # before_action :redirect_if_not_signed_in, only: [:new]

  def show
    @post = Post.includes(:tags).find(params[:id])
    @comments = @post.comments.includes(:user)
    @steps = @post.steps.order('id').paginate(:per_page => 1, :page => params[:page])
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
      authorize! :menage, @post
      @categories = Category.all
      @step = Step.new
      @steps = @post.steps.order("id")
    end

    def destroy
      authorize! :menage, @post
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
      
      respond_to do |format|
        if @post.save 
          format.html { redirect_to @post, notice: 'Post was successfully created.' }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render :edit }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
      authorize! :create, @post
    end

    def update
      authorize! :menage, @post
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
      params.require(:post).permit(:content, :title, :img_url, :category_id, :tag_list, :rate)
                           .merge(user_id: current_user.id)
    end
end
