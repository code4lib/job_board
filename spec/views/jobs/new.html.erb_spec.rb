require 'rails_helper'

RSpec.describe "jobs/new", type: :view do
  before(:each) do
    assign(:job, Job.new(
      :title => "MyString",
      :origin => "MyString",
      :url => "MyString",
      :description => "MyText",
      :user => "",
      :type => 1,
      :telecommute => false,
      :employer => "",
      :location => "MyText",
      :contact => "MyText",
      :published => false
    ))
  end

  it "renders new job form" do
    render

    assert_select "form[action=?][method=?]", jobs_path, "post" do

      assert_select "input#job_title[name=?]", "job[title]"

      assert_select "input#job_origin[name=?]", "job[origin]"

      assert_select "input#job_url[name=?]", "job[url]"

      assert_select "textarea#job_description[name=?]", "job[description]"

      assert_select "input#job_user[name=?]", "job[user]"

      assert_select "input#job_type[name=?]", "job[type]"

      assert_select "input#job_telecommute[name=?]", "job[telecommute]"

      assert_select "input#job_employer[name=?]", "job[employer]"

      assert_select "textarea#job_location[name=?]", "job[location]"

      assert_select "textarea#job_contact[name=?]", "job[contact]"

      assert_select "input#job_published[name=?]", "job[published]"
    end
  end
end
