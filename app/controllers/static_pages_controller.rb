class StaticPagesController < ApplicationController
	before_action :require_user, only: [:home]

	def home
		@pins = Pin.all
	end
end
