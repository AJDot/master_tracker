Rails.application.routes.draw do
  root to: 'spreadsheets#show'

  resources :spreadsheets, only: [:show, :update] do
    resources :rows, only: [:create]
  end

  # namespace :api, :contraints => {:subdomain => "api"} do
  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      resources :entries, only: [:index, :update]
    end
  end
  resources :entries, only: [:index, :new, :create]
  resources :categories, only: [:index, :new, :create]
  resources :skills, only: [:index, :new, :create]
  resources :descriptions, only: [:index, :new, :create]
end
