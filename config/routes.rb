Rails.application.routes.draw do  
  root :to => 'pins#index' 
  
  get 'pins/new', to:'pins#new'
  get '/pins/:id' => 'pins#show', as: :pin

  post '/pins/:id/edit' => 'pins#edit'

  get '/companies', to:'companies#show'
  get '/companies', to: 'companies#update'
  post '/companies', to: 'companies#update'

  match 'static_pages#home',  to: 'static_pages#home', via: 'get'
  

  get 'signup'  => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :users
  resources :pins do
    member do
       put "like", to: "pins#upvote" 
       put "dislike", to: "pins#downvote"
    end
  end
  resources :pins do
    put :favorite, on: :member
  end
end