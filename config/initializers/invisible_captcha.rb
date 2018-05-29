InvisibleCaptcha.setup do |config|
  config.honeypots = ['subtitle', 'keywords', 'phone']
  config.timestamp_enabled = !Rails.env.test?
end
