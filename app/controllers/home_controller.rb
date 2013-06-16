class HomeController < ApplicationController
	before_filter :authenticate_user! ,:except => [:index,:features,:contactus,:howtouse]
	before_filter :set_cache_buster
	def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  	end
	
	def index

	end

	def home
		@famcount = Family.where(:username=> current_user.username).count
		@peoplecount = Person.where(:username=> current_user.username).count
		@multicount = Multicasts.where(:username=>current_user.username).count
	end

	def features
	

	end

	def contactus
	
	end
end
