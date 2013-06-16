task :scheduler => :environment do
	STDOUT.sync = true
	print "Scheduler Starting\n"
	
	loop do
			print "Scheduler running " , Time.now , "\n"
			t = Time.now
			list = Multicasts.where(:datetime.gte => t , :datetime.lte => t + 1.minutes,:active => 1)
			print list.to_a
			list.each do |multicast|
				
				if (multicast.sms_voice == "voice") # CALL

					multicast.people_ids.each do |per|
						Delayed::Job.enqueue(CallMaker.new(per,multicast.id,multicast.audio.url))
					end

				else # SMS
					multicast.people_ids.each do |per|
						p =  Person.where(:personid => per).first
						if (p)
							Delayed::Job.enqueue(SmsSender.new(p.mobnum.to_s[-10,10],multicast.message))
						else
							print "\nERROR : MULTICAST_SMS : Person with pid : ",per, " doesn't exist\n"
						end
					end
				end

				multicast.active = 2 # Multicast deployed
				multicast.save
			end
			print "\nGonna sleep now for 20 secs\n"
			sleep (20) # 1 minutes
	end

end