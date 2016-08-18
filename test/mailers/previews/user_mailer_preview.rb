# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # https://scorecliq-kpauls.c9users.io/rails/mailers/user_mailer/account_activation
  def account_activation
    user = User.first
    user.activation_token = User.new_token
    UserMailer.account_activation(user)
  end

  # https://scorecliq-kpauls.c9users.io/rails/mailers/user_mailer/password_reset
  def password_reset
    user = User.first
    user.reset_token = User.new_token
    UserMailer.password_reset(user)
  end
  
  def resend_activation
    user= User.first
    user.activation_token = User.new_token
    UserMailer.resend_activation(user)
  end

end
