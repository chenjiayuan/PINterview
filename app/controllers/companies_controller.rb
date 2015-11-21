class CompaniesController < ApplicationController
	def show
		@pins = Pin.all.paginate(:page => params[:page], :per_page => 20) 
	end
end