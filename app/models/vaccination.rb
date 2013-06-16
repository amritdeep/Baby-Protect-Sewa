class Vaccination
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes 

  field :remID , :type => Integer
  field :dab , :type => Integer # dab =>  Days after birth  (- 9months x 30days) to (10 years x 365 days) = -270 to 3650
  
  field :type , :default => "sms" # sms or voice
  
  field :message , :type => String ,:default => "Message"
  field :audio_url # if Voice

  validates_presence_of :remID
  validates_uniqueness_of :remID

end