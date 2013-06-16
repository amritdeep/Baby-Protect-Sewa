class RegistrationsController < Devise::RegistrationsController
  
  def after_sign_up_path_for(resource)
 	#SEND A welcome mail
   Usermailer.delay.welcomemail(resource)
   '/'
  end
  
end