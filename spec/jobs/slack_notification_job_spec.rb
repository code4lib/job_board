require 'rails_helper'

describe SlackNotificationJob do
  let(:job) { Job.new id: 123 }
  it 'is a no-op if the slack webhook is not configured' do
    allow(Settings.slack).to receive(:webhook_url).and_return(nil)
    expect { SlackNotificationJob.perform_now(job) }.not_to raise_error
  end
  
  context 'with a webhook url' do
    let(:stubs) do
      Faraday::Adapter::Test::Stubs.new do |stub|
        stub.post('') { |env| [ 200, {}, '{}' ]}
      end
    end
    let(:conn) do
      Faraday.new do |builder|
        builder.adapter :test, stubs
      end
    end

    before do
      allow(Settings.slack).to receive(:webhook_url).and_return('http://example.com/')
      allow(Rails.application.config.action_mailer).to receive(:default_url_options).and_return({ host: 'example.com' })
      allow(Faraday).to receive(:new).with(url: 'http://example.com/').and_return(conn)
    end
    
    it 'sends a notification' do
      SlackNotificationJob.perform_now(job)

      stubs.verify_stubbed_calls
    end
  end
end
