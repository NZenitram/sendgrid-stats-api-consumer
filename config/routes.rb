Rails.application.routes.draw do
  root to: 'home#welcome'

  get '/global', to: 'home#index'
  get '/providers', to: 'home#providers'

  namespace :api do
    namespace :v1 do
      resources :providers, only: [:show], param: :slug
    end
  end

  post '/dates', to: 'home#search'
end
