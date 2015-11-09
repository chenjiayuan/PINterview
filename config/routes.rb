Rails.application.routes.draw do  
  root :to => 'pins#index' 
  
  get 'pins/new', to:'pins#new'
  get '/pins/:id' => 'pins#show', as: :pin

  match 'static_pages#home',  to: 'static_pages#home', via: 'get'
  

  get 'signup'  => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :users
  resources :pins do
    member do
       put "like", to: "pins#upvote"      
    end
  end
end