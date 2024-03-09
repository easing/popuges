class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def doorkeeper
    Rails.logger.debug "request.env['omniauth.auth']"
    Rails.logger.debug request.env["omniauth.auth"]

    user = User.from_omniauth(request.env["omniauth.auth"])

    if user.present?
      sign_out_all_scopes
      sign_in :user, user
      redirect_to root_path
    else
      redirect_to new_user_session_path
    end
  end
end