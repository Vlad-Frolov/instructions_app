class UsersController < ApplicationController
  respond_to :html, :json
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @posts.order(params[:sort])
    respond_to do |format|
      format.html
      format.json {render :json => @user}
    end
  end
  
  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    respond_with @user
  end

  def destroy
    authorize! :manage, :all
    @user = User.find(params[:id]).destroy
    if @user.destroy
      respond_to do |format|
        format.html { redirect_to posts_path }
        format.json { head :no_content }
      end
    end
  end 

end