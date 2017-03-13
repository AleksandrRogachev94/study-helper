Rails.application.routes.draw do

  resources :categories

  # UsersController and nested lessons.
  resources :users do
    resources :lessons
    get '/:rel_type' => 'studyships#index', as: "studyships"
    delete ':rel_type/:id' => 'studyships#destroy', as: "studyship"
  end

  # Devise
  devise_for :users, path: 'u'

  # Establishing connections between students and teachers. StudentshipsController
  resources :studyships, only: [:create, :destroy]

  root 'static#home'
end
