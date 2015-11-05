class UsersController < ApplicationController
  before_action :require_user, only: [:show, :edit]
  before_action :not_require_user, only: [:new]
  def new
    @user = User.new
  end

  def create 
    @user = User.new(user_params) 
    if @user.save 
      session[:user_id] = @user.id 
      redirect_to '/' 
    else 
      redirect_to '/signup' 
    end 
  end

  def show
    @user = User.find(params[:id])
    @pins = Pin.where(:user_id => @user.id)
  end
  
  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :grad_class, :major)
  end
end
