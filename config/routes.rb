Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#index'
  
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'signup', to: 'devise/registrations#new'

  end
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :posts do
    collection do
      get 'hobby'
    end
  end
end
