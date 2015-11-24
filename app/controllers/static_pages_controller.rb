class StaticPagesController < ApplicationController
	before_action :require_user, only: [:home]

	def home
		@search = Pin.search(params[:q])
		@pins = @search.result
	end
end
