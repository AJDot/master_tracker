Rails.application.routes.draw do
  root to: 'welcome#index'

  resources :welcome, only: [:index]

  get '/register', to: 'users#new', as: 'register'
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'

  resources :users, only: [:show, :create, :edit, :update] do
    resources :spreadsheets, only: [:show, :new, :create, :edit, :update], path: 'sheets' do
      member do
        patch 'rows', to: 'rows#update'
      end
      resources :rows, only: [:create, :destroy]
    end
    resources :entries, only: [:index, :new, :create, :edit, :update]
    resources :categories, only: [:new, :create, :edit, :update]
    resources :skills, only: [:new, :create, :edit, :update]
    resources :descriptions, only: [:new, :create, :edit, :update]
    resources :stopwatches, only: [:index]
    post 'new_stopwatch_entry', to: 'entries#new_stopwatch_entry'
  end

  # namespace :api, :contraints => {:subdomain => "api"} do
  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      resources :users, only: [] do
        resources :entries, only: [:index]
        resources :categories, only: [:index]
        resources :skills, only: [:index]
        resources :descriptions, only: [:index]
      end
    end
  end
end
