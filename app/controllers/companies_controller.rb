class CompaniesController < ApplicationController
	def show
		@pin = Pin.all
	end
end

