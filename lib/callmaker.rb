require 'rubygems'
require 'plivo'
require 'pry'

class CallMaker < Struct.new(:pid ,:multiid,:audio_url)
	def perform
		
		authid = "MAMJQZZMY2Y2JINDGWOW"
		authtoken = "ZGMwNjlhNTYzMzYyMTcxZDlhZjAyOWEwMzUxNjAz"
		
		call = Calls.new
		call.pid = pid
		call.audio_url = audio_url
		call.multiid = multiid
		call.messages = Array.new

		

		per = Person.where(:personid => pid).first
		
		if(per)
			call.mobnum = per.mobnum
			call.pname = per.fname + " " + per.mname + " " + per.lname 
			
			p = Plivo::RestAPI.new(authid, authtoken)
			# Making a call
			params = {'to' => "91" + call.mobnum, # setting for making calls to India
			           'from' => '919016761992', 
			           'callback_url' => 'http://ngoservice.herokuapp.com/api/init',
			           'answer_url' => 'http://ngoservice.herokuapp.com/api/ans',
			           'answer_method' => 'POST',
			           'hangup_url' => 'http://ngoservice.herokuapp.com/api/hangup',
			        }

			response = p.make_call(params)
			
			call.messages << response[1]["message"]
			call.api_id = response[1]["api_id"]
			call.save 
			print "\nDONE SPAWNING CALL ",pid," ",call.mobnum," ",multiid,"\n"
		else
			print "\nERROR : Person with pid : ",pid, " doesn't exist\n"
		end
	end

end