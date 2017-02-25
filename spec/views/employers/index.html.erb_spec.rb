require 'rails_helper'

RSpec.describe "employers/index", type: :view do
  before(:each) do
    assign(:employers, Kaminari.paginate_array([
      Employer.create!(
        :name => "Name",
        :description => "MyText",
        :address => "MyAddress"
      ),
      Employer.create!(
        :name => "Name",
        :description => "MyText",
        :address => "MyAddress"
      )
    ]).page(1))
  end

  it "renders a list of employers" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
