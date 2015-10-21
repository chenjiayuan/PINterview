class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      #flash[:success] = "Welcome to PINterview!"
      redirect_to :root
    else
      render 'new'
    end
  end

  def edit
  end

  def destory
  end

  def user_params
    params.require(:user).permit(:username, :email, :password,
                                 :password_confirmation, :grad_class, :major)
  end
end
