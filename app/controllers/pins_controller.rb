class PinsController < ApplicationController
	before_action :require_user, only: [:index, :new, :create, :show, :edit, :destroy, :update, :upvote, :favorite]
  
  def index
    @search = Pin.ransack(params[:q])
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
    if @pin.save    	
      	redirect_to "/"
    else
        flash[:error] = @pin.errors.full_messages.to_sentence 
      	redirect_to "new_pin"
    end
  	end 

    def show
      @pin = Pin.find(params[:id])
      #@is_favorite = Pin.get_favorite(params[:id])
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

    elsif type == "Unmark" # Else user selects 'unfavorite' on post
      current_user.favorites.delete(@pin)
      redirect_to :back, notice: "Unmark #{@pin.id}"

    else # Type missing, nothing happens
      redirect_to :back, notice: "Nothing happened."
    end
  end

  	private
  	def pin_params
      params.require(:pin).permit(:position, :company, :date, :difficulty, :type_interview, 
        :attire, :questions, :like_count, :length, :description, :user_id)
  	end 

    def updatelike
      @pin.update_attribute(:like_count, @pin.get_upvotes.size - @pin.get_downvotes.size)
    end
end
