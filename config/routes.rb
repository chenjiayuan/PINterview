Rails.application.routes.draw do
 
  get 'pins/new' # create new pins

  get 'pins/edit' # edit pins

  get 'pins/show' # to see specific pins

  get 'users/show' #see your profile page

  get 'users/new' #signup page

  get 'users/edit' #edit user

  root to: 'static_pages#home'

  get '/welcome',  to: 'static_pages#welcome'
  get 'static_pages/help'
  
end
