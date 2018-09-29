SecureHeaders::Configuration.default do |config|
  config.cookies[:secure] = SecureHeaders::OPT_OUT unless Rails.env.production?

  # thanks CKEditor...
  config.csp[:script_src] +=  ['\'unsafe-inline\'']

  unless Rails.env.production?
    config.csp[:default_src] += ['http:']
    config.csp[:img_src] += ['http:']
    config.csp[:script_src] += ['http:']
    config.csp[:style_src] += ['http:']
  end

end
