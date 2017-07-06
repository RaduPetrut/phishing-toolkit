Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get '/login',   to: 'sessions#new'
  post '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  post '/start/campaign', to: 'campaigns#start_campaign'

  post '/create/report', to: 'reports#create_report'

  resources :users
  resources :campaigns
  resources :templates
  resources :reports
end
