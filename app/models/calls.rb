class Calls
  include Mongoid::Document

  field :multiid
  field :pid
  field :pname
  field :mobnum

  field :audio_url

  field :api_id
  field :request_uuid
  field :messages , :type => Array

end
