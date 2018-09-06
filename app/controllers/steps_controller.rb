class StepsController < ApplicationController
  before_action :set_step, only: [:edit, :destroy, :update]
  
  def edit
  
  end

  def create
    @post = Post.find(params[:post_id])
    authorize! :manage, @post
    @step = Step.new(:post=>@post)
    @step = Step.create(step_params)
    @step.content = ""
    respond_to do |format|
      if @step.save
        format.html { redirect_to edit_post_path(@post.id), notice: 'Step was successfully created.' }
        format.json { render :show, status: :created, location: @step }
      else
        format.html 
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize! :manage, Post
    @step.destroy
    respond_to do |format|
      format.html { redirect_to edit_post_path(@step.post.id) }
      format.json { head :no_content }
    end
  end

  def update
    authorize! :manage, Post
    respond_to do |format|
      if @step.update(step_params)
        format.html { redirect_to edit_post_path(@step.post_id), notice: 'Step was successfully updated.' }
        format.json { render :show, status: :ok, location: @step }
      else
        format.html { render :edit }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_step
    @step = Step.find(params[:id])
  end

  def step_params
    params.require(:step).permit(:post_id, :name, :content, :img_url)
  end

end