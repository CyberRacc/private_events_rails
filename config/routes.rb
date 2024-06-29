Rails.application.routes.draw do
  root 'events#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :events do
    resources :event_attendees, only: [:create, :destroy]
  end

  resources :users, only: [:show]
end
