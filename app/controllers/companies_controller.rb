class CompaniesController < ApplicationController
  before_action :require_user, only: [:show, :edit]
  
	def show
		@pin = Pin.all
	end
end

