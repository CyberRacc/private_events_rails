Rails.application.routes.draw do
  root 'events#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :events do
    resources :event_attendees, only: [:create, :destroy]
    member do
      post 'invite'
    end
  end

  resources :users, only: [:show] do
    member do
      get 'invitations'
      post 'accept_invitation/:invitation_id', to: 'users#accept_invitation', as: 'accept_invitation'
      post 'reject_invitation/:invitation_id', to: 'users#reject_invitation', as: 'reject_invitation'
    end
  end
end
