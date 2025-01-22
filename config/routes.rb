require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  devise_for :users, skip: [:sessions, :registrations]

  namespace :api do
    namespace :v1 do
      devise_scope :user do
        post 'login', to: 'users/sessions#create'
        delete 'logout', to: 'users/sessions#destroy'
        post 'signup', to: 'users/registrations#create'
      end

      post 'test_notification', to: 'notifications#test'
      get 'assets/teams/:filename', to: 'assets#show'
      resources :users, only: [:index]
      resources :teams
      resources :players
      resources :games do
        collection do
          get 'available_dates'
        end
      end
      resources :favorite_teams, only: [:index, :create, :destroy]
      resources :favorite_players, only: [:index, :create, :destroy]
      resources :player_games, only: [:index]
      resources :device_tokens, only: [:create] do
        collection do
          get :status
          post :test
        end
      end
    end
  end
end
