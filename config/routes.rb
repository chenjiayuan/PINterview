Rails.application.routes.draw do  
  root :to => 'static_pages#home' 
  
  get 'pins/new', to:'pins#new'
  
  match 'static_pages#home',  to: 'static_pages#home', via: 'get'
  

  get 'signup'  => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :users
  resources :pins
end