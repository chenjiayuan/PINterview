Rails.application.routes.draw do  
  root :to => 'static_pages#home' 
  get 'pins/new', to:'pins#new'
  #post 'pins' => 'pins#create'
  match 'static_pages#home',  to: 'static_pages#home', via: 'get'
  resources :pins  
end