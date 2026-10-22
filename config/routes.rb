Rails.application.routes.draw do
  get "how_to_uses/show"
  devise_for :users

  get "profile", to: "profiles#show"
  get "profile/edit", to: "profiles#edit", as: :edit_profile
  patch "profile/edit", to: "profiles#update"
  get "how_to_use", to: "how_to_uses#show"
  get "challenges", to: "challenges#index", as: :challenges
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#landing"

  get "/home", to: "home#index", as: :home

  resources :photos do
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
    resources :challenges, only: [:new, :create, :edit, :update, :destroy]
  end

  resources :techniques, only: [:show]

end
