Rails.application.routes.draw do
  root to: 'spreadsheets#show'

  get '/', to: "spreadsheets#show", as: 'home'
  resources :entries, only: [:index, :new, :create]
  resources :categories, only: [:index, :new, :create]
  resources :skills, only: [:index, :new, :create]
  resources :descriptions, only: [:index, :new, :create]
end
