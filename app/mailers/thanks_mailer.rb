class ThanksMailer < ApplicationMailer
  
  def welcome_email(user)
    @user = user
    mail(subject: "新規登録完了のお知らせ", to: user.email)
  end
end
