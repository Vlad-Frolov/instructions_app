Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#index'
  
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'signup', to: 'devise/registrations#new'

  end
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :posts do
    resources :steps, :only => [:create, :update, :edit, :destroy, :clear]
  end
  post 'update_step', to: 'steps#update_step', as: 'update_step'
  resources :steps do
    put :sort, on: :collection
  end
end
