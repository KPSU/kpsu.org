class DjApplication < ActionMailer::Base
  default :from => "<noreply>@kpsu.org"

  def new_applicantion_notification(applicant)
      @applicant = applicant
      mail(:to => "admin@kpsu.org",
           :from => default,
           :subject => "New Dj Application Submitted")
  end
end
