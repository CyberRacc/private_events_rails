Rails.application.routes.draw do
  devise_for :users

  resources :events, only: [:edit, :update, :new, :create]

  root to: 'events#index'
end
