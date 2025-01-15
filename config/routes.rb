Rails.application.routes.draw do
  devise_for :users, skip: [:sessions, :registrations]

  namespace :api do
    namespace :v1 do
      get 'assets/teams/:filename', to: 'assets#show'
      devise_scope :user do
        post '/signup', to: 'users/registrations#create'
        post '/login', to: 'users/sessions#create'
        delete '/logout', to: 'users/sessions#destroy'
      end

      resources :users, only: [:index]
      resources :teams
      resources :players
      resources :games
      resources :favorite_teams, only: [:index, :create, :destroy]
      resources :favorite_players, only: [:index, :create, :destroy]
    end
  end
end
