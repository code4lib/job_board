Rails.application.routes.draw do
  resources :jobs do
    collection do
      get 'type/:job_type', to: 'jobs#index', as: :type
    end
  end
  resources :employers
  resources :tags, only: [:index, :show]
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'jobs#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
