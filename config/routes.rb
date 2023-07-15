Rails.application.routes.draw do
  root to: 'sessions#new'
  resources :tasks
  resources :users
  resources :sessions

  namespace :admin do
    resources :users
  end

  namespace :admin do
    resources :users do
      patch '/grant_admin', to: 'users#grant_admin', on: :member
    end
  end

  namespace :admin do
    resources :users do
      patch '/deprive_admin', to: 'users#deprive_admin', on: :member
    end
  end
end
