Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # http_method 'path', to: 'controller#action'
  # get '/users', to: 'users#index'
  # get '/users/:id', to: 'users#show'
  # post '/users', to: 'users#create'
  # patch '/users/:id', to: 'users#update'
  # delete '/users/:id', to: 'users#destroy'

  # resources :users # makes all the restful routes
  # resources :users, except: [:new,:edit] # makes all routes except the routes in the array
  resources :users do # make only the routes in the array
    resources :chirps, only: [:index]
  end

  resources :chirps, only: [:show]

  resource :session, only: [:new,:create,:destroy]
  
end
