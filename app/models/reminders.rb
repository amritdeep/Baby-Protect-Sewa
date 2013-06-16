class Reminders  # Unicast reminders
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes 

  field :username , :type => String
  
  field :famid
  field :pid
  
  field :serviceID , :type => String
  field :remID , :type => Integer
  field :datetime , :type => DateTime
  field :done , :type => Integer , :default => 0
  field :status 

end
