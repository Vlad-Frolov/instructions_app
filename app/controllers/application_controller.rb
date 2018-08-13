class ApplicationController < ActionController::Base
  include CanCan::ControllerAdditions  
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path
    flash[:danger] = "U don't have permissions"
   end

  def redirect_if_not_signed_in
        redirect_to root_path if !user_signed_in?
      end
      
      def redirect_if_signed_in
        redirect_to root_path if user_signed_in?
      end
end
