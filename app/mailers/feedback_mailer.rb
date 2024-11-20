class FeedbackMailer < ApplicationMailer
  default to: 'olehkavetskyi@gmail.com' # Replace with the recipient's email

  def feedback_email(params)
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]

    mail(
      subject: 'User Feedback',
      from: @email
    )
  end
end
