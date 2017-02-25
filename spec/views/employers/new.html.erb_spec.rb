require 'rails_helper'

RSpec.describe "employers/new", type: :view do
  before(:each) do
    assign(:employer, Employer.new(
      :name => "MyString",
      :description => "MyText",
      :address => "MyText"
    ))
  end

  it "renders new employer form" do
    render

    assert_select "form[action=?][method=?]", employers_path, "post" do

      assert_select "input#employer_name[name=?]", "employer[name]"

      assert_select "textarea#employer_description[name=?]", "employer[description]"

      assert_select "textarea#employer_address[name=?]", "employer[address]"
    end
  end
end
