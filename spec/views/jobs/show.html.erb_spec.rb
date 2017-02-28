require 'rails_helper'

RSpec.describe "jobs/show", type: :view do
  let(:basic_job) do
    Job.create!(
      :title => "MyTitle",
      :url => "Url",
      :description => "MyText",
      :job_type => :full_time,
      :telecommute => true,
      :location => "MyText",
      :contact => "MyText",
      :published => false,
      :employer_name => 'foo'
    )
  end

  let(:job) { basic_job }

  before(:each) do
    @job = assign(:job, job)
  end

  it 'renders the title in an <h1>' do
    render
    expect(rendered).to have_selector 'h1', text: 'MyTitle'
  end

  it 'renders the job type as a badge' do
    render
    expect(rendered).to have_selector '.badge', text: 'Full time'
  end

  it 'links to the employer' do
    render
    expect(rendered).to have_link('foo', href: employer_path(@job.employer))
  end

  it 'links to the original job description' do
    render
    expect(rendered).to have_content 'How to apply'
    expect(rendered).to have_link('Url', href: 'Url')
  end

  it 'contains metadata about when the job was created' do
    render
    expect(rendered).to have_content 'Metadata'
    expect(rendered).to have_content 'Created: ' + view.l(@job.created_at)
    expect(rendered).not_to have_content 'Updated:'
    expect(rendered).not_to have_content 'Published:'
    expect(rendered).to have_selector '.badge', text: 'Unpublished'
  end

  describe 'telecommute jobs' do
    before do
      job.update(telecommute: true)
    end

    it 'shows the job is a telecommute position' do
      render
      expect(rendered).to have_selector '.badge', text: 'Remote / Telecommute'
    end
  end

  describe 'tags' do
    before do
      job.tag_list = 'rspec, testing'
      job.save
    end

    it 'displays the tags' do
      render
      expect(rendered).to have_selector '.badge', text: 'rspec'
      expect(rendered).to have_selector '.badge', text: 'testing'
    end
  end

  describe 'for a published job' do
    let(:job) do
      basic_job.publish!
      basic_job
    end

    it 'contains metadata about when the job was published' do
      render
      expect(rendered).to have_content 'Metadata'
      expect(rendered).to have_content 'Created: ' + view.l(@job.created_at)
      expect(rendered).to have_content 'Updated: ' + view.l(@job.updated_at)
      expect(rendered).to have_content 'Published: ' + view.l(@job.published_at)
      expect(rendered).not_to have_selector '.badge', text: 'Unpublished'
    end
  end
end
