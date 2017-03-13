Rails.application.routes.draw do

  resources :categories

  # UsersController and nested lessons.
  resources :users do
    resources :lessons

    # Establishing connections between students and teachers. StudentshipsController
    get '/:rel_type' => 'studyships#index', as: "studyships"
    post '/:rel_type' => 'studyships#create'
    delete ':rel_type/:id' => 'studyships#destroy', as: "studyship"
  end

  resources :requests, only: [:create, :destroy, :index]


  # Devise
  devise_for :users, path: 'u'

  root 'static#home'
end
