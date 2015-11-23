class CompaniesController < ApplicationController
  before_action :require_user, only: [:show, :edit]
  
	def show
		@pins = Pin.all.paginate(:page => params[:page], :per_page => 20) 
	end
end