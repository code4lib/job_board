SecureHeaders::Configuration.default do |config|
  config.cookies = {
    secure: Rails.env.production?, # mark all cookies as "Secure"
    httponly: true, # mark all cookies as "HttpOnly"
    samesite: {
      lax: true # mark all cookies as SameSite=lax
    }
  }
  
  unless Rails.env.production?
    config.csp[:default_src] += ['http:']
    config.csp[:img_src] += ['http:']
    config.csp[:script_src] += ['http:']
    config.csp[:style_src] += ['http:']
  end

end
