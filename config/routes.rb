Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  
  get 'home/index'
  root "posts#index"

  resources :posts do
    resources :comments
  end
end
