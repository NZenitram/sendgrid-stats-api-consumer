Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'users/sessions'}
  devise_scope :user do
    root to: "devise/sessions#new"
  end

  get '/welcome', to: 'home#welcome'
  get '/global', to: 'home#index'
  get '/providers', to: 'home#providers'
  get '/top-five', to: 'home#topfive'

  namespace :api do
    namespace :v1 do
      resources :providers, only: [:show], param: :slug
      get '/percentage', to: 'providers#percentage'
    end
  end

  get '/user-id', to: 'home#id'
  post '/dates', to: 'home#search'
end
