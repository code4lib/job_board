class OmniAuth::Strategies::Code4lib < OmniAuth::Strategies::OAuth2
  option :name, :code4lib
  option :client_options, Settings.oauth.code4lib.client_options
  option :scope, "openid offline_access email profile"

  uid { raw_info['sub'] }

  info do
    {
      :email => raw_info['email']
    }
  end

  extra do
    {
      'raw_info' => raw_info
    }
  end

  def raw_info
    @raw_info ||= access_token.get('/oauth2/userinfo').parsed
  end

  def callback_url
    full_host + script_name + callback_path
  end
end
