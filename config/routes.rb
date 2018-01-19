Rails.application.routes.draw do
  root to: 'welcome#index'

  resources :welcome, only: [:index]

  get '/register', to: 'users#new', as: 'register'
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'

  resources :users, only: [:show, :create] do
    resources :spreadsheets, only: [:show, :update], path: 'sheets' do
      resources :rows, only: [:create]
    end
    resources :entries, only: [:index, :new, :create]
    resources :categories, only: [:index, :new, :create]
    resources :skills, only: [:index, :new, :create]
    resources :descriptions, only: [:index, :new, :create]
  end


  # namespace :api, :contraints => {:subdomain => "api"} do
  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      resources :entries, only: [:index, :update]
    end
  end
end
