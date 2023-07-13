Rails.application.routes.draw do
  root to: 'sessions#new'
  resources :tasks
  resources :users
  resources :sessions

  namespace :admin do
    resources :users
  end
end
