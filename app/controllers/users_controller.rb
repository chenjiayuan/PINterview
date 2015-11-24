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
      flash[:error] = "Invalid Credential"

      redirect_to '/signup', notice: 'New user failed to create.'
    end 
  end

  def show    
    if current_user.id == Integer(params[:id])
      @user = User.find(params[:id])
      @pins = @user.pins
      @favorite = @user.favorites
      @calendar = [] 
      @pins.each do |p|
        @calendar.push({'title' => "#{p.company}", 'start' => "#{p.date}", "allDay" => "1"})
      end
      respond_to do |format|
        format.html
        format.json { render json:@calendar.to_json }
      end
    else
      redirect_to '/' 
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :grad_class, :major)
  end
end
