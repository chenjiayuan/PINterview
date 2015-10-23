class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:username, :email, :password, :password_confirmation, :grad_class, :major))
    @user.save

    @user = User.last
    @total = {status: 1, user: @user}
    respond_to do |format|
      format.html{
        render json: @total
      }
      format.json{
        render json: @total
      }
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
