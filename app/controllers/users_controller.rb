class UsersController < ApplicationController
  before_action :set_user
  respond_to :html, :json
  
  def show
    @posts = @user.posts.order('updated_at DESC')
    respond_to do |format|
      format.html
      format.json {render :json => @user}
    end
  end
  
  def destroy
    authorize! :manage, :all
    @user.destroy
    if @user.destroy
      respond_to do |format|
        format.html { redirect_to posts_path }
        format.json { head :no_content }
      end
    end
  end 

  private 
  
  def set_user
    @user = User.find(params[:id])
  end

end