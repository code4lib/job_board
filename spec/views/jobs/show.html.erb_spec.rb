require 'rails_helper'

RSpec.describe "jobs/show", type: :view do
  before(:each) do
    @job = assign(:job, Job.create!(
      :title => "MyTitle",
      :origin => "MyString",
      :url => "MyString",
      :description => "MyText",
      :job_type => :full_time,
      :telecommute => false,
      :location => "MyText",
      :contact => "MyText",
      :published => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyTitle/)
    expect(rendered).to match(/Origin/)
    expect(rendered).to match(/Url/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/false/)
  end
end
