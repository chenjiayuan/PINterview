class PinsController < ApplicationController
	before_action :require_user, only: [:new, :create, :show, :edit, :destroy]
  def new
    	@pin = Pin.new
  	end
  
  	def create
	    @pin = Pin.new(pin_params)
	    @pin.like_count = 0      
      current_user.pins << @pin
    if @pin.save    	
      	redirect_to "/"
    else
        flash[:error] = @pin.errors.full_messages.to_sentence 
      	redirect_to "new_pin"
    end
  	end 

    def show
      @pin = Pin.find(params[:id]) 
    end

    def edit
      
    end

    def destroy
      @pin = Pin.find_by_id(params[:id]).destroy
    end

  	private
  	def pin_params
      params.require(:pin).permit(:position, :company, :date, :difficulty, :type_interview, 
        :attire, :questions, :like_count, :length, :description, :user_id)
  	end 
end
