Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#index'

  get '/global', to: 'home#index'
  get '/providers', to: 'home#providers'
  get '/top-five', to: 'home#topfive'

  namespace :api do
    namespace :v1 do
      resources :providers, only: [:show], param: :slug
      get '/percentage', to: 'providers#percentage'
    end
  end

  post '/dates', to: 'home#search'
end
