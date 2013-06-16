class User
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes 
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :name,               :type => String, :default => ""
  field :gender
  field :mobnum,             :type => String, :default => ""
  
  field :area,              :type => String, :default => ""
  field :state,             :type => String, :default => ""
  field :ngo,             :type => String, :default => ""
  
  field :username,           :type => String, :default => ""
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""
  
  # State fields
  field :accverified,        :type => Integer , :default => 0
  # Unicast setting
  field :uni_act_inactive,    :type => Integer , :default => 1
  field :uni_sms_voice,        :type => String, :default => "sms" # sms or voice
  field :uni_days_before_rem,  :type => Integer , :default => 2
  field :uni_time_of_day, :type => Time, :default => 5.hours

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String
  attr_accessible :name, :gender, :area, :state,:ngo,:mobnum, :username , :email ,:password ,:password_confirmation,:accverified,:uni_act_inactive,:uni_sms_voice,:uni_days_before_rem,:uni_time_of_day
  validates_presence_of :username
  validates_uniqueness_of :username 
end
