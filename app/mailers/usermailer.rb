class Usermailer < ActionMailer::Base
  default from: "from@example.com"

  def welcomemail(user)
    @user = user
    mail(:from =>"hello@babyprotect.com" ,:to => user.email , :subject => "Thanks for registering on BabyProtect Seva+")  
  end
end
