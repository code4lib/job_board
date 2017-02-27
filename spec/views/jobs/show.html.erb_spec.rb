require 'rails_helper'

RSpec.describe "jobs/show", type: :view do
  before(:each) do
    @job = assign(:job, Job.create!(
      :title => "MyTitle",
      :url => "Url",
      :description => "MyText",
      :job_type => :full_time,
      :telecommute => false,
      :location => "MyText",
      :contact => "MyText",
      :published => false,
      :employer_name => 'foo'
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyTitle/)
    expect(rendered).to have_link('Url', text: 'Url')
    expect(rendered).to match(/MyText/)
    expect(rendered).not_to match(/Telecommute/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to have_selector '.badge-danger', text: 'Unpublished'
  end
end
