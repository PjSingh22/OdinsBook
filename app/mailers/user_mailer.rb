class UserMailer < ApplicationMailer
  default from: 'odinslist@website.com'

  def welcome_email
    @user = params[:user]
    @url = 'http://localhost:3000/users/sign_in'
    mail(to: @user.email, subject: 'Welcome to Odinslist!')
  end
end
