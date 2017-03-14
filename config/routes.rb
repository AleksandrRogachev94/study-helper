Rails.application.routes.draw do

  # Devise
  devise_for :users, path: 'u', controllers: { registrations: 'users_devise/registrations',
                                               omniauth_callbacks: "users_devise/omniauth_callbacks" }

  resources :users do
    resources :lessons
    # Establishing connections between students and teachers. StudentshipsController
    get '/:rel_type' => 'studyships#index', as: "studyships"
    post '/:rel_type' => 'studyships#create'
    delete ':rel_type/:id' => 'studyships#destroy', as: "studyship"
  end

  resource :profile, only: [:edit, :update]

  resources :categories
  resources :requests, only: [:create, :destroy, :index]
  root 'static#home'
end
