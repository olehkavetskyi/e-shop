class FeedbacksController < ApplicationController
  def new
    # Initialize a feedback object
  end

  def create
    Rails.logger.info "Params received: #{params.inspect}" # Logs all incoming parameters

    feedback_params = params.require(:feedback).permit(:name, :email, :message)

    FeedbackMailer.feedback_email(feedback_params).deliver_now

    redirect_to new_feedback_path, notice: 'Feedback sent successfully!'
  rescue => e
    Rails.logger.error "Failed to send feedback: #{e.message}"
    redirect_to new_feedback_path, alert: "Failed to send feedback: #{e.message}"
  end

end

