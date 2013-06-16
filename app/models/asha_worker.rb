class AshaWorker
  include Mongoid::Document
  field :username
  field :ashaID
  field :name
  field :mobnum
  validates_uniqueness_of :ashaID ,:mobnum, :message => 'Same Mobile number exists'
  validates_numericality_of :mobnum, :allow_nil => false, :presence => true, :message => 'Invalid Mobile number'
  validates :name, presence: true

end