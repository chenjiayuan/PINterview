class PinsController < ApplicationController
  skip_before_action :verify_authenticity_token

  # POST 'pins/new' - takes data from post method, creates a pin from data, then adds to DB
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

  # POST 'pins/edit/:id' - edits pin matching id from post method URI and data
  def edit
  end

  # GET 'pins' - gets all pins from DB
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

  # GET 'pins/show' - gets pin matching id from get method URI
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

  # DELETE 'pins/delete/:id' - deletes pin matching id from delete method URI
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
