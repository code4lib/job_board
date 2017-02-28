class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def authorize
    @user = User.from_omniauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => action_name.to_s.humanize) if is_navigational_format?
    else
      session["devise.#{action_name}_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
  
  alias code4lib authorize
  alias github authorize
  alias twitter authorize

  def failure
    redirect_to root_path
  end
end
