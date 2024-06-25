Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :events, only: [:edit, :update, :new, :create]
  resources :users, only: [:show]

  root 'events#index'
end
