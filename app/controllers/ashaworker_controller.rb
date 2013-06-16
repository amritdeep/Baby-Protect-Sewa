class AshaworkerController < ApplicationController
	before_filter :authenticate_user!
	def index

		

		if params[:asha_worker]
			resource = AshaWorker.new
			resource.update_attributes(params[:asha_worker])
			if resource.new_record?
				if !resource.valid?
					flash[:notice] = "One or more than field is empty/invalid"
				end
			end
		end
		@list = AshaWorker.where(:username => current_user.username)
		
	end
end
