class UsersController < ApplicationController
  respond_to :html, :json
  # def index
  #     @users = User.all
  #   authorize! :manage, User
    
    
  # end
  
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
  
  #   def block
  #     authorize! :manage, User
  #     User.where(id: params[:user_check]).update_all(role: "banned")
  #     respond_to do |format|
  #       format.html 
  #       format.js 
  #     end
  #     redirect_to users_url

  #   end
  
  #   def unblock
  #     authorize! :manage, User
  #     User.where(id: params[:user_check]).update_all(role: "user")
  #     respond_to do |format|
  #       format.html 
  #       format.js 
  #     end
  #     redirect_to users_url

  #   end

  #   def destroy
  #     authorize! :manage, User
  #     if params[:user_check]
  #       User.where(id: params[:user_check]).destroy_all
  #     end 
  #     respond_to do |format|
  #       format.html 
  #       format.js 
  #     end
  #     redirect_to users_url

  #   end

  #   def mkadmin
  #     User.where(id: params[:user_check]).update_all(role: "admin")
  #     respond_to do |format|
  #       format.html { render 'user' }
  #       format.js { }
  #   end
  #   index
      
  # end
end