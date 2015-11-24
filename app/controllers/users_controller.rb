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
      #@pins = Pin.where(:user_id => @user.id)
      #you can join the table as well, so up to front end decide
      @pins = @user.pins
      @favorite = @user.favorites
    else
      redirect_to '/' 
    end
    @data = [{ "title" => "New shift", "start" => "2015-11-19"},{ "title" => "New shift", "start" => "2015-11-19"}]
    respond_to do |format|
      format.html
      format.json { render json:@data.to_json }
    end
  end
  
  def testme  
      @user = { "title" => "New shift", "start" => "2015-11-19"}
      render json: @user.to_json
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :grad_class, :major)
  end
end
