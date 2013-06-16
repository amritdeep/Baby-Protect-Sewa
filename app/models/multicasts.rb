class Multicasts
  include Mongoid::Document
  include Mongoid::Paperclip
  include Mongoid::MultiParameterAttributes 
  
  field :active ,:type => Integer , :default => 0 # inactive default
  field :username 
  field :datetime ,:type => DateTime

  field :sms_voice , :default => "sms"  #sms or voice
  
  field :when , :default => "im"  #im(immediate) or lat
  
  field :message , :default => "Multicast message here .. " # If sms multicast
  
  field :people_ids , :type => Array
  has_mongoid_attached_file :audio, # if Voice multicast
  	:path           => ':attachment/:id/:style.:extension',
    :storage        => :s3,
    :bucket => 'ngoservice',
    :s3_credentials => File.join(Rails.root, 'config', 's3.yml'),
    :default_url => '/notset'

  validates_attachment_content_type :audio, :content_type => ['audio/mpeg', 'audio/x-mpeg', 'audio/mp3', 'audio/x-mp3', 'audio/mpeg3', 'audio/x-mpeg3', 'audio/mpg', 'audio/x-mpg', 'audio/x-mpegaudio' ],
                                    :message => 'file must be of filetype .mp3'



end
