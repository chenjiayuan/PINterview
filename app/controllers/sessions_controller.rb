class SessionsController < ApplicationController
	before_action :not_require_user, only: [:new]

	def create
	  @user = User.find_by_email(params[:session][:email])
	  if @user && @user.authenticate(params[:session][:password])
	    session[:user_id] = @user.id
	    redirect_to '/', notice: 'Session was successfully created.'
	  else	  	
        flash[:error] = @user.errors.full_messages.to_sentence 
		redirect_to 'login'
	  end
	end

	def destroy 
	  session[:user_id] = nil 
	  redirect_to '/' 
	end
end
