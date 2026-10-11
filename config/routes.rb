Rails.application.routes.draw do
  devise_for :users

  get "profile", to: "profiles#show"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#landing"

  get "/home", to: "home#index", as: :home

  resources :photos do
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
    resources :challenges, only: [:new, :create, :destroy]
  end
end
