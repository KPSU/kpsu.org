class Notifier < ActionMailer::Base
  default :from => "from@example.com"

  def app_notification(applicant)
      @applicant = applicant
      mail(:to => "admin@kpsu.org",
           :from => applicant.email,
           :subject => "New DJ APplication")
  end
end
