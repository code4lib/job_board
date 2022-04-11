require 'rails_helper'

RSpec.describe Employer, type: :model do
  it 'uses distinct when listing employers' do
    employer = described_class.create name: 'The Library'
    (1..5).each { |job| Job.create employer: employer, title: job, description: job, job_type: job, published: true }
    expect(described_class.with_published_jobs.count).to eq(1)
  end
end
