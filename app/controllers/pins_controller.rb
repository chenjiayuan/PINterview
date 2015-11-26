class PinsController < ApplicationController
	before_action :require_user, only: [:index, :new, :create, :show, :edit, :destroy, :update, :upvote, :favorite]
  
  def index
    @search = Pin.ransack(params[:q])
    @search.sorts = 'id desc' if @search.sorts.empty?
    @pins = @search.result.paginate(:page => params[:page], :per_page => 20)
    @search.build_condition
    @search.build_sort
  end

  def new
  	@pin = Pin.new
  end
  
	def create
    @pin = Pin.new(pin_params)
    current_user.pins << @pin
    @pin.company = @pin.company.capitalize
    if @pin.save    	
      	redirect_to current_user
    else
        flash[:error] = "Invalid Inputs"
      	redirect_to new_pin_path
    end
	end 

  def show
    @pin = Pin.find(params[:id])
    if Pin.count > 1 
      @random_pin = Pin.where.not(id: params[:id]).order("RANDOM()").first
    end
  end

  def edit
    @pin = Pin.find(params[:id])
    if current_user.id != @pin.user_id     
      redirect_to '/' 
    end
  end

  def update
    @pin = Pin.find(params[:id])
    if @pin.update_attributes(pin_params)
      redirect_to @pin
    else
      flash[:error] = "Invalid Inputs"
      redirect_to edit_pin_path
    end

  end

  def destroy
    @pin = Pin.find_by_id(params[:id]).destroy
    redirect_to '/'
  end

  def upvote
    @pin = Pin.find_by_id(params[:id])
    @pin.upvote_by current_user 
    updatelike
    redirect_to :back
  end

  def downvote
    @pin = Pin.find_by_id(params[:id])
    @pin.downvote_by current_user 
    updatelike
    redirect_to :back
  end

  def favorite
    type = params[:type] # See posts/show
    @pin = Pin.find(params[:id])
    if type == "Mark" # If user selects 'favorite' on post
      current_user.favorites << @pin
      redirect_to :back, notice: "You mark #{@pin.id}"
      @pin.update_attribute(:like_count, @pin.like_count+1)

    elsif type == "Unmark" # Else user selects 'unfavorite' on post
      current_user.favorites.delete(@pin)
      redirect_to :back, notice: "Unmark #{@pin.id}"
      @pin.update_attribute(:like_count, @pin.like_count-1)

    else # Type missing, nothing happens
      redirect_to :back, notice: "Nothing happened."
    end
  end

  private
	def pin_params
    params.require(:pin).permit(:position, :company, :date, :difficulty, :type_interview, 
      :attire, :questions, :like_count, :length, :description, :user_id, :position_type)
	end 

  def updatelike
    @pin.update_attribute(:like_count, @pin.get_upvotes.size - @pin.get_downvotes.size)
  end
end
