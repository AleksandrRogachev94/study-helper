Rails.application.routes.draw do

  resources :categories

  resources :users do
    resources :lessons
  end

  devise_for :users, path: 'u'

  root 'static#home'
end
