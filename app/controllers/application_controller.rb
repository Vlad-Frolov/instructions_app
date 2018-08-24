class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include CanCan::ControllerAdditions  
  before_action :set_locale


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

  private 

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options = {})
    { locale: I18n.locale}.merge options
  end


end
