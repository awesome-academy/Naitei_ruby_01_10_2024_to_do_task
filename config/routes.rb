Rails.application.routes.draw do
  root "static_pages#home"

  get "static_pages/home"
  get "users/new"
  get "users/edit"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
end
