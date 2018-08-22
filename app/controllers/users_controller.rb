class UsersController < ApplicationController
  def index
    @users = User.all
  end  
  
  def show
      @user = User.find(params[:id])
    end

    def block
    
      User.where(id: params[:user_check]).update_all(role: "banned")
 
    end
  
    def unblock
      User.where(id: params[:user_check]).update_all(role: "user")
  
    end

    def destroy
      if params[:user_check]
        User.where(id: params[:user_check]).destroy_all
      end  
    end

    def mkadmin
      User.where(id: params[:user_check]).update_all(role: "admin")
    end
end