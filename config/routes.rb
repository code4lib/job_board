Rails.application.routes.draw do
  resources :jobs do
    collection do
      get 'type/:job_type', to: 'jobs#index', as: :type
      get 'moderate', to: 'moderate#index', as: :moderate
    end

    member do
      get 'publish', to: 'moderate#publish', as: :publish
    end
  end
  resources :employers
  resources :tags, only: [:index, :show]
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  get '/users/login', to: 'home#login', as: 'user_login'
  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
