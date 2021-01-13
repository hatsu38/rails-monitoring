Rails.application.routes.draw do
  resources :comments
  root "posts#index"
  resources :posts
end
