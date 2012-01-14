class PasswordReset < ActionMailer::Base
  default :from => "noreply@kpsu.org"
  def password_reset_instructions(user)
    @subject    =  "Password Reset Instructions"
    @from       =   "KPSU Website<noreply@kpsu.org>"
    @recipients =   user.email
    @sent_on    =   Time.zone.now
    body        = "Click the link below to reset your password. \n\n"  
    body        +=      "http://kpsu.org/reset_password/" + "?id=" + user.perishable_token
    body        +=      "\n\n Rock on, \n KPSU"
    @body = body
  end
end
