class Person
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes

  belongs_to :family
  field :personid
  field :username

  field :fname
  field :mname
  field :lname

  field :adult ,:type => Integer , :default => 1

  field :gender  # m or f
  field :dob, :type => Date
  field :mobnum
  field :occupation
  field :health_insurance_num
  
  field :village

  # female
  field :delivery_date ,:type => Date
  field :pregnant_status ,:type => Integer , :default => 0
  field :reminder_enabled ,:type => Integer , :default => 0 # 0 for off
  field :gen1
  field :gen2
  field :gen3
  field :gen4
  field :gen5

  validates_presence_of :username, :message => 'Username required'
  validates_presence_of :fname, :message => 'First name required'
  validates_presence_of :lname, :message => 'Last name required'
  validates_presence_of :adult, :message => 'Adult/Child required'
  validates_presence_of :gender, :message => 'Gender required'
  validates_presence_of :dob, :message => 'Date of Birth required'
  validates_presence_of :village,:message => 'Village name required'

  
end