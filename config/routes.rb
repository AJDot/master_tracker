Rails.application.routes.draw do
  root to: 'spreadsheets#show'

  get '/', to: "spreadsheets#show", as: 'home'
  resources :categories, only: [:index]
end
