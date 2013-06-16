class ManagedbController < ApplicationController
	before_filter :authenticate_user! 
	def index
		@famcount = Family.where(:username=> current_user.username).count
		@peoplecount = Person.where(:username=> current_user.username).count
		render :index ,:layout  => 'managedb'
	end

	def new
		@family = Family.new
		@family.famid = "FID"+((Time.now.to_f)*10000).to_i.to_s
		asha_list = AshaWorker.where(:username => current_user.username)
		@asha_wokers = Array.new
		asha_list.each do |asha|
			@asha_wokers  << [asha.name + " [" + asha.ashaID+"]",asha.ashaID]
		end
		
		if @asha_wokers.count == 0 
			render :new_empty , :layout => false
		else
			render :new , :layout => false
		end
	end

	def create
		family = Family.where(:famid => params[:family][:famid]).first
		if family

		else
			family = Family.new
			family.update_attributes(params[:family])
			family.username = current_user.username
			params[:persons].each do |key, per|
				person = Person.new
			
				person.update_attributes(per)
				person.personid = "PID"+((Time.now.to_f)*10000).to_i.to_s
				person.village = family.village
				person.username = current_user.username
				

				if (person.adult == 0) ## disable reminder child
					person.reminder_enabled = 0
					person.pregnant_status = 0
				else ## if adult and male disable reminder
					if(person.gender == 'm')
						person.reminder_enabled = 0
						person.pregnant_status = 0
					end
				end
				


				if person.save					
					family.people << person
				else
					print "ERROR : ",person.errors.full_messages.to_sentence
				end

			
				if (person.adult == 1) && (person.gender == 'f') && (!person.new_record?) && (person.reminder_enabled ==1)# Adult Female
					#TODO
				end

			end
			family.save
		end
		@fam = family
		render :create
	end

	def update
		if request.post?
			if params[:dosearch1] 
				searchHash = Hash.new
				searchHash[:username] = current_user.username
				if params[:onoff1] && params[:onoff1]["famid"]&& params[:search][:famid]
					searchHash[:famid] = params[:search][:famid]
					
					fam  = Family.where(searchHash).first
					if fam 
						@r1 = fam.people
					else
						@r1 = Array.new
					end
					render :update 
					return
	
			
				else

					if params[:onoff1]
						params[:onoff1].each do |key,val|
							searchHash[key] = params[:search][key]
						end
					end
					@r1 = Person.where(searchHash)
					render :update 
					return
	
				end	

				
			end
		else
			
			render :update 
			return
		end

	end

	def edit
		
		if request.get? ## Display the editable family record - GET request

			if params[:famid] ## This is the family 'object' ID
				@family = Family.find(params[:famid])
				@famobjid = params[:famid]
				asha_list = AshaWorker.where(:username => current_user.username)
				@asha_wokers = Array.new
				asha_list.each do |asha|
					@asha_wokers  << [asha.name + " [" + asha.ashaID+"]",asha.ashaID]
				end
				@persons = @family.people
				render :edit 
			else	
				redirect_to :action => :index
			end
		else	## Saving Changes - POST request

			if params[:family]
				#1. Get family
				#2. Update values
				#3. Delete all people	
				#4. Create new people + create scheduled reminders
				#5. Save family

				family = Family.find(params[:famobjid])
				family.update_attributes(params[:family])

				family.people.delete_all

				params[:persons].each do |key, per|
					person = Person.new
				
					person.update_attributes(per)
					person.personid = "PID"+((Time.now.to_f)*10000).to_i.to_s
					person.village = family.village
					person.username = current_user.username

					if (person.adult == 0) ## disable reminder child
						person.reminder_enabled = 0
						person.pregnant_status = 0
					else ## if adult and male disable reminder
						if(person.gender == 'm')
							person.reminder_enabled = 0
							person.pregnant_status = 0
						end
					end

					if person.save					
						family.people << person
					else
						print "ERROR : ",person.errors.full_messages.to_sentence
					end

					
					print person.adult , person.gender,person.pregnant_status ,person.new_record?,person.reminder_enabled 
				
					if (person.adult == 1) && (person.gender == 'f') && (person.pregnant_status == 1) && (!person.new_record?) && (person.reminder_enabled ==1)# Adult Female
						#TODO
						print 'here'
					
					end
				end
				family.save


				

				@fam = family

				render :updated

			else	
				redirect_to :action => :index
			end
		end

	end

	def delete
		if request.post?
			if params[:dosearch1] 
				searchHash = Hash.new
				searchHash[:username] = current_user.username
				if params[:onoff1] && params[:onoff1]["famid"]&& params[:search][:famid]
					searchHash[:famid] = params[:search][:famid]
					
					fam  = Family.where(searchHash).first
					if fam 
						@r1 = fam.people
					else
						@r1 = Array.new
					end
					render :delete 
					return
	
			
				else

					if params[:onoff1]
						params[:onoff1].each do |key,val|
							searchHash[key] = params[:search][key]
						end
					end
					@r1 = Person.where(searchHash)
					render :delete 
					return
	
				end	

				
			end
		else
			
			render :delete 
			return
		end
	end

	def delete_conf
		if request.get?
			if params[:famid]
				@fam = params[:famid]
				@family = Family.find(params[:famid])
				asha_list = AshaWorker.where(:username => current_user.username)
				@asha_wokers = Array.new
				asha_list.each do |asha|
					@asha_wokers  << [asha.name + " [" + asha.ashaID+"]",asha.ashaID]
				end

				@persons = @family.people
				render :delete_conf
				

			else	
				redirect_to :action => :index
			end
		else # POST request
			if params[:family]
				family = Family.where(:famid => params[:family][:famid]).first
				if family

					family.people.delete_all
					family.delete
					@mess = "Delete Successful"
				else
					@mess = "Family record not found"
						
				end 
					render :delete_result
			else	
				redirect_to :action => :index
			end
		end
	end

end