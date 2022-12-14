Rails.application.routes.draw do
  root 'static_pages#home'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get    '/search',  to: 'searches#search'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :microposts,          only: [:create, :destroy, :show, :new]
  resources :relationships,       only: [:create, :destroy]
end
