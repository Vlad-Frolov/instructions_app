class StepsController < ApplicationController
    before_action :set_step, only: [:edit, :destroy]
    skip_before_action :verify_authenticity_token
    respond_to :js, :json, :html
    def edit
     
    end

    def create
        @post = Post.find(params[:post_id])
        @step = Step.new(:post=>@post)
        @step = Step.create(step_params)
        @step.content = ""
        respond_to do |format|
          if @step.save
            format.html { redirect_to edit_post_path(@post.id), notice: 'Step was successfully created.' }
            format.json { render :show, status: :created, location: @step }
          else
            format.html { render :new }
            format.json { render json: @step.errors, status: :unprocessable_entity }
          end
        end
      end

      def destroy
        
        @step.destroy
        respond_to do |format|
          format.html { redirect_to edit_post_path(@step.post.id) }
          format.json { head :no_content }
        end
      end

    
  def update
    @step = Step.find(params[:id])
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

    def sort
        params[:order].each do |key,value|
          Step.find(value[:id]).update_attribute(:position,value[:position])
        end
      end

    private

    def set_step
      @step = Step.find(params[:id])
    end

    def step_params
        params.require(:step).permit(:post_id, :name, :content, :img_url )
    end

end
