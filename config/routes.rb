Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :teams
      devise_scope :user do
        post 'signup', to: 'users/registrations#create'
        post 'login', to: 'users/sessions#create'
        delete 'logout', to: 'users/sessions#destroy'
      end
    end
  end
end
