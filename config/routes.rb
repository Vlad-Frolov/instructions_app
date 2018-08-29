Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
    post '/rate' => 'rater#create', :as => 'rate'
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    root to: 'pages#index'
    
    devise_scope :user do
      get 'login', to: 'devise/sessions#new'
      get 'signup', to: 'devise/registrations#new'
    end
    get 'tags/:tag', to: 'posts#index', as: :tag
    
    resources :users, :only => [:show, :update]
    # post 'users/block', :as => :block_data
    # post 'users/unblock', :as => :unlock_data
    # post 'users/mkadmin', :as => :mkadmin
    # delete 'users/destroy', :as => :destroy
    resources :posts, :only => [:index, :show, :update, :edit, :destroy, :new]
    resources :posts do
      resources :steps, :only => [:create, :update, :edit, :destroy, :clear]
    end
  
    resources :steps do
      put :sort, on: :collection
    end
    resources :posts do
      get :autocomplete_tag_list_tag, :on => :collection
    end
  
    match '*path' => redirect('/'), via: :get
    mount ActionCable.server => '/cable'
    resources :comments do 
      member do
        put "like", to: "comments#upvote"
        put "dislike", to: "comments#downvote"
      end
    end
  end
end