class OmniauthCallbacksController < ApplicationController
    def google_oauth2
        @user = User.google_from_omniauth(request.env["omniauth.auth"])
      sign_in_and_redirect @user
    end
end
