Rails.application.routes.draw do

  resources :lessons
  resources :categories
  root 'static#home'

  devise_for :users
end
