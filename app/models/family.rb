class Family
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes 

  has_many :people

  field :username
  field :famid
  field :cardNum
  field :ashaID
  field :village
  validates_presence_of :village
end