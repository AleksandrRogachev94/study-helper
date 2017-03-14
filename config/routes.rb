Rails.application.routes.draw do

  # Devise
  devise_for :users, path: 'u', controllers: { registrations: 'users_devise/registrations' }

  # UsersController and nested lessons.
  resources :users do
    resource :profile, only: [:edit, :update]
    resources :lessons
    # Establishing connections between students and teachers. StudentshipsController
    get '/:rel_type' => 'studyships#index', as: "studyships"
    post '/:rel_type' => 'studyships#create'
    delete ':rel_type/:id' => 'studyships#destroy', as: "studyship"
  end

  resources :categories
  resources :requests, only: [:create, :destroy, :index]
  root 'static#home'
end
