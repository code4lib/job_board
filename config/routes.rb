Rails.application.routes.draw do
  resources :jobs
  resources :employers
  resources :tags, only: [:index, :show]
  devise_for :users

  root to: 'jobs#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
