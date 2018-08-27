class UsersController < ApplicationController
  def index
    @users = User.all
  end  
  
  def show
    @user = User.find params[:id]
    respond_to do |format|
      format.html
      format.json {render :json => @user}
    end
  end

  def update
    @post = Post.find(params[:id])
  
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content } # 204 No Content
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end
  
    def block
    
      User.where(id: params[:user_check]).update_all(role: "banned")
      respond_to do |format|
        format.html 
        format.js 
      end

    end
  
    def unblock
      User.where(id: params[:user_check]).update_all(role: "user")
      respond_to do |format|
        format.html 
        format.js 
      end

    end

    def destroy
      if params[:user_check]
        User.where(id: params[:user_check]).destroy_all
      end 
      respond_to do |format|
        format.html 
        format.js 
      end

    end

    def mkadmin
      User.where(id: params[:user_check]).update_all(role: "admin")
      respond_to do |format|
        
          format.html { redirect_to @users, notice: "Save process completed!" }
          format.json { render json: @users, status: :created, location: @users }
      end
  end
end