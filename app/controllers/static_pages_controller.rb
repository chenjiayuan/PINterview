class StaticPagesController < ApplicationController
	def home
		@pins = Pin.all
	end
end
