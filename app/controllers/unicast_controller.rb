class UnicastController < ApplicationController
	before_filter :authenticate_user!
	def index
		if request.post?
			
			current_user.update_attributes(params[:unicast])


			@message = "Your Changes have been saved"

		end
		
	end
end
