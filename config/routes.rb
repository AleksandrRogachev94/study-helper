Rails.application.routes.draw do

  resources :categories

  # UsersController and nested lessons.
  resources :users do
    resources :lessons
    get 'teachers' => 'studyships#teachers'
    get 'students' => 'studyships#students'
  end

  # Devise
  devise_for :users, path: 'u'

  # Establishing connections between students and teachers. StudentshipsController
  resources :studyships, only: [:create, :destroy]

  root 'static#home'
end
