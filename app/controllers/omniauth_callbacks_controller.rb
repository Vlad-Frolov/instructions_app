class OmniauthCallbacksController < ApplicationController
  def facebook
    @user = User.facebook_from_omniauth(request.env["omniauth.auth"])
    sign_in_and_redirect @user
    end  
    def vkontakte
        @user = User.vkontakte_from_omniauth(request.env["omniauth.auth"])
        sign_in_and_redirect @user
      end
      def github
        @user = User.from_omniauth(request.env["omniauth.auth"])
        sign_in_and_redirect @user
      end
     
    def google_oauth2
        @user = User.google_from_omniauth(request.env["omniauth.auth"])
      sign_in_and_redirect @user
    end
end
