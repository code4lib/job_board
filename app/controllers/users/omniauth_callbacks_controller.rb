class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def code4lib
    @user = User.from_code4lib_omniauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Code4lib") if is_navigational_format?
    else
      session["devise.code4lib_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def github
    @user = User.from_github_omniauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Github") if is_navigational_format?
    else
      session["devise.github_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def twitter
    @user = User.from_twitter_omniauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
    else
      session["devise.twitter_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
  
  def failure
    redirect_to root_path
  end
end
