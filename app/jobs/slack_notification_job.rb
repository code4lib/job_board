class SlackNotificationJob < ApplicationJob
  def perform(job)
    return unless Settings.slack.webhook_url

    conn.post do |req|
      req.headers['Content-Type'] = 'application/json'
      req.body = message_body(job).to_json
    end
  end

  private

  def conn
    Faraday.new(url: Settings.slack.webhook_url)
  end

  def message_body(job)
    {
      attachments: [
        {
          fallback: job.display_title,
          author_name: job.employer_name,
          title: job.title,
          title_link: Rails.application.routes.url_helpers.job_url(id: job.id, host: Rails.application.config.action_mailer.default_url_options[:host]),
          color: "#36a64f",
          text: ActionView::Base.full_sanitizer.sanitize(job.description)
        }
      ]
    }
  end
end
