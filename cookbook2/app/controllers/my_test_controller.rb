class MyTestController < ApplicationController
	def index
		render :text => "Hello world"
	end
	def dilbert
		render :text => "Wow, easy!"
	end
end
