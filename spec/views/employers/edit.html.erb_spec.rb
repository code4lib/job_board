require 'rails_helper'

RSpec.describe "employers/edit", type: :view do
  before(:each) do
    @employer = assign(:employer, Employer.create!(
      :name => "MyString",
      :description => "MyText",
      :address => "MyText"
    ))
  end

  it "renders the edit employer form" do
    render

    assert_select "form[action=?][method=?]", employer_path(@employer), "post" do

      assert_select "input#employer_name[name=?]", "employer[name]"

      assert_select "textarea#employer_description[name=?]", "employer[description]"

      assert_select "textarea#employer_address[name=?]", "employer[address]"
    end
  end
end
