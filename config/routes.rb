Rails.application.routes.draw do
  root 'homes#index'

  resources :doctors do
    resources :reviews
  end
end
