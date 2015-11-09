class PinsController < ApplicationController
	before_action :require_user, only: [:new, :create, :show, :edit, :destroy, :update]
  
  def index
    @search = Pin.search(params[:q])
    @pins = @search.result 
  end
  
  def new
    	@pin = Pin.new
  	end
  
  	def create
	    @pin = Pin.new(pin_params)	     
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
        flash[:error] = @pin.errors.full_messages.to_sentence 
        redirect_to @pin
      end

    end

    def destroy
      @pin = Pin.find_by_id(params[:id]).destroy
    end

    def upvote
      @pin = Pin.find_by_id(params[:id])
      @pin.upvote_by current_user
      redirect_to :back
    end

  	private
  	def pin_params
      params.require(:pin).permit(:position, :company, :date, :difficulty, :type_interview, 
        :attire, :questions, :like_count, :length, :description, :user_id)
  	end 
end
