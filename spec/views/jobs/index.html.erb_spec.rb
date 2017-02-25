require 'rails_helper'

RSpec.describe "jobs/index", type: :view do
  before(:each) do
    assign(:jobs, [
      Job.create!(
        :title => "Title",
        :origin => "Origin",
        :url => "Url",
        :description => "MyText",
        :user => "",
        :type => 2,
        :telecommute => false,
        :employer => "",
        :location => "MyText",
        :contact => "MyText",
        :published => false
      ),
      Job.create!(
        :title => "Title",
        :origin => "Origin",
        :url => "Url",
        :description => "MyText",
        :user => "",
        :type => 2,
        :telecommute => false,
        :employer => "",
        :location => "MyText",
        :contact => "MyText",
        :published => false
      )
    ])
  end

  it "renders a list of jobs" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Origin".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
