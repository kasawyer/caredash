Rails.application.routes.draw do
  resources :doctors do
    resources :reviews
  end
end
