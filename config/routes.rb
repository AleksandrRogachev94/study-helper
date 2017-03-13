Rails.application.routes.draw do

  resources :categories

  resources :users do
    resources :lessons, only: [:show, :index, :new]
  end
  resources :lessons, only: [:create, :update, :destroy]

  devise_for :users, path: 'u'

  root 'static#home'
end
