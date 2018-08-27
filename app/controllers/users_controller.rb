class UsersController < ApplicationController
  def index
    authorize! :menage, User
    @users = User.all
    
  end  
  
  def show
    @user = User.find params[:id]
    respond_to do |format|
      format.html
      format.json {render :json => @user}
    end
  end

  # def update
  #   @post = Post.find(params[:id])
  
  #   respond_to do |format|
  #     if @post.update_attributes(params[:post])
  #       format.html { redirect_to @user, notice: 'User was successfully updated.' }
  #       format.json { head :no_content } # 204 No Content
  #     else
  #       format.html { render action: "edit" }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  
    def block
      authorize! :menage, User
      User.where(id: params[:user_check]).update_all(role: "banned")
      respond_to do |format|
        format.html 
        format.js 
      end
      redirect_to users_url

    end
  
    def unblock
      authorize! :menage, User
      User.where(id: params[:user_check]).update_all(role: "user")
      respond_to do |format|
        format.html 
        format.js 
      end
      redirect_to users_url

    end

    def destroy
      authorize! :menage, User
      if params[:user_check]
        User.where(id: params[:user_check]).destroy_all
      end 
      respond_to do |format|
        format.html 
        format.js 
      end
      redirect_to users_url

    end

    def mkadmin
      authorize! :menage, User
      User.where(id: params[:user_check]).update_all(role: "admin")
      respond_to do |format|
        format.html
        format.js
      end
      redirect_to users_url
  end
end