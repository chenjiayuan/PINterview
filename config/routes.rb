Rails.application.routes.draw do

  get 'pins/new', to:'pins#new'

  post 'pins/new', to: 'pins#create'

  post 'pins/edit/:id', to: 'pins#update'

  get 'pins', to: 'pins#index'

  get 'pins/show', to: 'pins#show'

  delete 'pins/delete/:id', to: 'pins#destroy'
  
  resources :users
  root to: 'static_pages#home'

  get '/welcome',  to: 'static_pages#welcome'
  get 'static_pages/help'
  
end
