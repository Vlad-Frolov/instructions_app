Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#index'
  
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'signup', to: 'devise/registrations#new'
  end
  get 'tags/:tag', to: 'posts#index', as: :tag
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  resources :users, :only => [:show, :index, :update, :edit, :destroy]
  resources :posts, :only => [:index, :show, :update, :edit, :destroy]
  resources :posts do
    resources :steps, :only => [:create, :update, :edit, :destroy, :clear]
  end
  post 'update_step', to: 'steps#update_step', as: 'update_step'
  resources :steps do
    put :sort, on: :collection
  end
  
  mount ActionCable.server => '/cable'

end