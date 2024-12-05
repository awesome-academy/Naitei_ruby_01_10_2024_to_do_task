Rails.application.routes.draw do
  root "static_pages#home"

  get "static_pages/home"
  get "users/new"
  get "users/edit"
  get "sessions/new"
end
