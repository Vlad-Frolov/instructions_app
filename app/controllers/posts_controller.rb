class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy]
  autocomplete :tag_list, :tag

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user).order('created_at')
    @steps = @post.steps.paginate(:per_page => 1, :page => params[:page])
    respond_to do |format|
      format.html 
      format.json { render json: @steps }
      format.js
      format.pdf do
        render pdf: "#{@post.title}",
        template: "posts/pdf.html.erb",
        layout: 'pdf.html',
        encoding: "utf8"
      end
    end
  end
        
  def index
    @posts = get_posts.includes(:category).paginate(page: params[:page])
    @categories = Category.all
    respond_to do |format|
      format.html
      format.js { render partial: 'posts/posts_pagination_page' }
    end 
  end

  def edit
    authorize! :manage, @post
    @categories = Category.all
    @step = Step.new
    @steps = @post.steps.order("id")
  end

  def destroy
    authorize! :manage, @post
    @post.destroy
    if @post.destroy
      respond_to do |format|
        format.html { redirect_to posts_path }
        format.json { head :no_content }
      end
    end
  end 

  def get_posts
    category = params[:category]
    tag = params[:tag]
    search =  params[:val]
    if search.present?
      @posts = Post.search(search)
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
    authorize! :manage, @post
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
    params.require(:post).permit(:content, :title, :img_url, :category_id, :tag_list, :video_url)
                          .merge(user_id: current_user.id)
  end
end
