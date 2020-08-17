class ApplicationMailer < ActionMailer::Base
  default from: ENV["noreply"]
  layout "mailer"
end
