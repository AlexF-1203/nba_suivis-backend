Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :teams
      resources :users
    end
  end
  devise_for :users,
  controllers: {
    sessions: 'api/v1/users/sessions',
    registrations: 'api/v1/users/registrations'
  },
  defaults: { format: :json }
end
