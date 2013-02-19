class ReleaseNotifier < ActionMailer::Base
  default from: 'Street Date <no-reply@streetdate.info>'

  def notify(user)
    @user = user
    mail to: user[0].email, subject: "You have new albums out today!"
  end

end
