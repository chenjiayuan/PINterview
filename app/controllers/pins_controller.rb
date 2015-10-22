class PinsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
  	@pin = Pin.new(params.require(:pin).permit(:title, :company, :date, :difficulty, :type, :attire, :questions, :like_count, :length, :description)) 
  	@pin.save

  	@pin = Pin.last
	@total = {status: 1, pin: @pin}
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

  def index
  	@pin = Pin.all
  	@total = {status: 1, pins: @pin}
	respond_to do |format|
	  format.html{
		render json: @total
	  }
	  format.json{
		render json: @total
	  }
	end	

  end

  def show
  	@pin = Pin.find_by_id(params[:id])
  	@total = {status: 1, pin: @pin}
  	respond_to do |format|
	  format.html{
		render json: @total
	  }
	  format.json{
		render json: @total
	  }
	end	

  end

  def destroy
  	@pin = Pin.find_by_id(params[:id]).destroy

	@total = {status: 1}
	respond_to do |format|
	  format.html{
	    render json: @total

	  }
	  format.json{
	    render json: @total
	  }
	end	

  end

end
