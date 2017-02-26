require 'rails_helper'

RSpec.describe "jobs/index", type: :view do
  before(:each) do
    assign(:jobs, Kaminari.paginate_array([
      Job.create!(
        :title => "Title",
        :origin => "MyString",
        :url => "MyString",
        :description => "MyText",
        :job_type => :full_time,
        :telecommute => false,
        :location => "MyLocation",
        :contact => "MyText",
        :published => false
      ),
      Job.create!(
        :title => "Title",
        :origin => "MyString",
        :url => "MyString",
        :description => "MyText",
        :job_type => :full_time,
        :telecommute => false,
        :location => "MyLocation",
        :contact => "MyText",
        :published => false
      )
    ]).page(1))
  end

  it "renders a list of jobs" do
    render
    assert_select "tr>td>.badge", :text => "Full time".to_s, :count => 2
    assert_select "tr>td>a", :text => "Title".to_s, :count => 2
    assert_select "tr>td>.small", :text => "MyLocation".to_s, :count => 2
  end
end
