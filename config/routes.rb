Rails.application.routes.draw do

  resources :categories do
    resources :lessons
  end

  resources :users
  devise_for :users, path: 'u'

  root 'static#home'
end
