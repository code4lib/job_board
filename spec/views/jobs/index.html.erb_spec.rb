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
        :published => false,
        :employer_name => 'foo'
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
        :published => false,
        :employer_name => 'foo'
      )
    ]).page(1))
  end

  it "renders a list of jobs" do
    render
    assert_select ".badge", :text => "Full time".to_s, :count => 2
    assert_select "a", :text => "Title".to_s, :count => 2
    assert_select ".card-subtitle", :text => "foo — MyLocation".to_s, :count => 2
  end
end
