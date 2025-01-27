Rails.application.routes.draw do
  root 'pages#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

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

  get 'up' => 'rails/health#show', as: :rails_health_check
end
