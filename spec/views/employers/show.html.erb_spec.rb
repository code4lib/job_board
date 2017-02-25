require 'rails_helper'

RSpec.describe "employers/show", type: :view do
  before(:each) do
    @employer = assign(:employer, Employer.create!(
      :name => "Name",
      :description => "MyText",
      :address => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
