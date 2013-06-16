class MulticastController < ApplicationController
	before_filter :authenticate_user!

	# index > search > select > upload/set_sms > schedule > confirm
	
	def index
	
	end

	def last_multicast
		@multicast = Multicasts.where(:username => current_user.username).desc(:id).first
		if @multicast
			if @multicast.sms_voice == "voice"
				@calls = Calls.where(:multiid => @multicast.id)
			end
		end
	end

	def get_progress_multi
		if params[:multiid]
			@multicast = Multicasts.find(params[:multiid])
			print @multicast
			if @multicast
				
				if @multicast.sms_voice == "voice"
					
					@calls = Calls.where(:multiid => @multicast.id)
					
					render :progress_multi , :layout => false
				end
			else
				render :text => "..."
			end

		else
			render :text => "..."
		end

	end

	def search # search and show results for selection
		render :new_search , :layout => false
	end
	
	def getResults
		if request.post?
			if params[:dosearch] 
				searchHash = Hash.new
				searchHash[:username] = current_user.username
				if params[:onoff]
					params[:onoff].each do |key,val|
						searchHash[key] = params[:search][key]
					end
				end
				@results = Person.where(searchHash).to_a
				render :new_results , :layout => false
				return
			end
		end
	end
	
	def select
		if request.post?
			if params[:persons] # Save selection

				@multicast = Multicasts.new
				@multicast.datetime = Time.now
				@multicast.username = current_user.username
				@multicast.people_ids = Array.new
				params[:persons].each do |per|
					@multicast.people_ids << per
				end
				
				@multicast.save
				render :select

			else
				redirect_to :controller=> :multicast,:action=>:index
			end
		else
			redirect_to :controller=> :multicast,:action=>:index
		end

	end

	def upload	# upload file or save sms message > show schedule date time
		
		if request.post?

			if params[:multicast] # process
				par = params[:multicast]
				@multicast = Multicasts.find(params[:multicast][:id])
				
				x = Hash.new
				x["datetime(3i)"] = par["datetime(3i)"]
				x["datetime(2i)"] = par["datetime(2i)"]
				x["datetime(1i)"] = par["datetime(1i)"]
				x["datetime(4i)"] = par["datetime(4i)"]
				x["datetime(5i)"] = par["datetime(5i)"]
				@multicast.update_attributes(x)

				@multicast.sms_voice = par[:sms_voice]
				@multicast.when = par[:when]

				
				if par[:sms_voice] == "sms"
					@multicast.message = par[:message] 
				else
					@multicast.audio = par[:audio] 
				end	

				if @multicast.save # save successful
					if @multicast.sms_voice == "voice" and @multicast.audio.url == "/notset"

						@error_messages = Hash.new
						@error_messages[:required] = "Audio file is required"
						render :select
						return

					else
						
						redirect_to :action => :confirm , :multiid =>@multicast.id
						return
					end
					
					
				else # save not successsful
					@error_messages = @multicast.errors.messages
					render :select
					return
				end	
			else
				redirect_to :controller=> :multicast,:action=>:index
			end

		else
			redirect_to :controller=> :multicast,:action=>:index
		end
	end
	
	def confirm # show confirmation message > activate multicast or delete it
		if request.get?
			if params[:multiid]
				@multicast = Multicasts.find(params[:multiid])
				render :confirm
			else
				redirect_to :controller=> :multicast,:action=>:index
			end
		else #POST
			if params[:multicast][:id]
				@multicast = Multicasts.find(params[:multicast][:id])
				@multicast.active = 1
				if @multicast.when == "im"
					@multicast.datetime = Time.now + 2.minutes
				end
				@multicast.save
				@done =1
					render :confirm
			else
				redirect_to :controller=> :multicast,:action=>:index
			end
		end

	end

	### need to reposition code below ###
	def create
		

	end
end
