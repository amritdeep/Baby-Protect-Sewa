class ApiController < ApplicationController
  
  def init
  	reshash = JSON.parse params["response"]
  	call = Calls.where(:api_id => reshash["api_id"]).first
  	if call 
  		call.request_uuid = reshash["request_uuid"]
  		call.messages << reshash["message"]
  		call.save
  		print "\nCall fired api_id: ",reshash["api_id"]," request_uuid : ",reshash["request_uuid"],"\n"
  	else
  		print "\nERROR : CALL not found - api_id"
  	end
  	

  end

  def ans
  	print "\nParams\n",params,"\n\n"

    reqid = params["RequestUUID"]
    call = Calls.where(:request_uuid => reqid).first
   
    if call
      @url = call.audio_url
      call.messages << params["CallStatus"]
      call.save
      render :ans , :layout => false
      return
    else
        print "\nERROR : CALL not found - request_uuid"
        render :text => "ERROR" 
        return
    end
  	
  end

  def hangup
  	print "\nParams\n",params,"\n\n"

    reqid = params["RequestUUID"]
    call = Calls.where(:request_uuid => reqid).first
   
    if call
      call.messages << params["CallStatus"]
      call.save
      render :hangup , :layout => false
      return
    else
        print "\nERROR : CALL not found - request_uuid"
        render :text => "ERROR" 
        return
    end

  end

end
