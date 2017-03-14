Rails.application.routes.draw do
  root to: 'home#index'

  namespace :api do
    namespace :v1 do
      resources :providers, only: [:show], param: :slug
    end
  end
end
