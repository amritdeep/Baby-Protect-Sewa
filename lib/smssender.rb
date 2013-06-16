require "net/http"
class SmsSender < Struct.new(:recipient ,:message)
	def perform

		sender = "7878778830"
		password = "ilovesen"
		provider = "site2sms"
		puts "SmsSender : Sending SMS to #{recipient}\n"
		uri = URI("http://smsapi.cikly.in/index.php")
		params = { uid: sender,
		pwd: password,
		phone: recipient,
		msg: message,
		provider: provider
		}
		uri.query = URI.encode_www_form(params)
		response = Net::HTTP.get_response(uri)
		response_code = response.body.to_i
		puts "Response : "+ response_code.to_s
		return response_code
	end

end