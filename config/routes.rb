Rails.application.routes.draw do
  root 'pages#index'

  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :bookmarks, only: [:index]
  resources :books do
    resources :comments, only: %i[create]
    resource :bookmark, only: %i[create destroy]
    member do
      patch :like
      post :borrow
      post :return
      post :bookmark
    end
    resources :ratings, only: %i[create]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
