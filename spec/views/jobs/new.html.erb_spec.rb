require 'rails_helper'

RSpec.describe "jobs/new", type: :view do
  before(:each) do
    assign(:job, Job.new(
      :title => "MyString",
      :origin => "MyString",
      :url => "MyString",
      :description => "MyText",
      :job_type => :full_time,
      :telecommute => false,
      :location => "MyText",
      :contact => "MyText",
      :published => false,
      :employer_name => 'foo'
    ))
  end

  it "renders new job form" do
    render

    assert_select "form[action=?][method=?]", jobs_path, "post" do

      assert_select "input#job_title[name=?]", "job[title]"

      assert_select "input#job_url[name=?]", "job[url]"

      assert_select "textarea#job_description[name=?]", "job[description]"

      assert_select "select#job_job_type[name=?]", "job[job_type]"

      assert_select "input#job_telecommute[name=?]", "job[telecommute]"

      assert_select "input#job_employer_name[name=?]", "job[employer_name]"

      assert_select "input#job_location[name=?]", "job[location]"

      assert_select "textarea#job_contact[name=?]", "job[contact]"
    end
  end
end
