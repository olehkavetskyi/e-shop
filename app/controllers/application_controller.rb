class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :load_categories

  # Include devise helpers for views
  helper_method :user_signed_in?, :current_user

  def load_categories
    @main_categories = Category.main_categories.includes(:subcategories)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end
end
ApplicationController.instance_methods.include?(:user_signed_in?)
