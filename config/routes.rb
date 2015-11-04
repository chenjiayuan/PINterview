Rails.application.routes.draw do  
  root :to => 'static_pages#home' 
  get 'pins/new', to:'pins#new'
  get '/welcome', to:'static_pages#welcome'
  #post 'pins' => 'pins#create'
  match 'static_pages#home',  to: 'static_pages#home', via: 'get'
  resources :pins

  get 'signup'  => 'users#new'
  get '/login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  resources :users
end