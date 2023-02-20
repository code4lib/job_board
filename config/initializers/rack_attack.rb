# Always allow requests from localhost
# (blocklist & throttles are skipped)
Rack::Attack.safelist('allow from localhost') do |req|
  # Requests are allowed if the return value is truthy
  '127.0.0.1' == req.ip || '::1' == req.ip
end

Rack::Attack.throttle('limit job posts by ip', limit: 2, period: 60) do |req|
  if req.path == '/jobs' && req.post?
    req.ip
  end
end

Rack::Attack.blocklist('spam') do |req|
  # `filter` returns truthy value if request fails, or if it's from a previously banned IP
  # so the request is blocked
  Rack::Attack::Fail2Ban.filter("spam-#{req.ip}", maxretry: 1, findtime: 10.minutes, bantime: 60.minutes) do
    req.path == '/jobs' && req.post? &&
      req.params['job'] && req.params['job']['description'] &&
      Settings.blocklist.any? { |r| Regexp.new(r) =~ req.params['job']['description'] }
  end
end

Rack::Attack.blocklist('block ip from failed recaptchas') do |req|
  # if variable `block <ip>` exists in cache store, then we'll block the request
  Rack::Attack::Fail2Ban.filter("block-#{req.ip}", maxretry: 1, findtime: 60.minutes, bantime: 1.day) do
    req.path == '/jobs' && Rails.cache.fetch("failed recaptcha #{req.ip}")
  end
end
