class PinsController < ApplicationController
	def new
    	@pin = Pin.new
  	end
  
  	def create
	    @pin = Pin.new(pin_params)
	    @pin.like_count = 0
      @pin.user_id = current_user.id if current_user
    if @pin.save    	
      	redirect_to "/"
    else
      	redirect_to "/pins/new"
    	end
  	end 

  	private
  	def pin_params
      params.require(:pin).permit(:position, :company, :date, :difficulty, :type_interview, 
        :attire, :questions, :like_count, :length, :description, :user_id)
  	end 
end
