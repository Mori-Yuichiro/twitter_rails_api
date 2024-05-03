# frozen_string_literal: true

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener'
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'users'
      resources :sessions, only: %i[index]
      resources :tweets, only: %i[index create show]
      resources :images, only: %i[create]
      put '/profile', to: 'profiles#update'
      resources :users, only: %i[show], controller: :profiles
    end
  end

  resources :tasks
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
