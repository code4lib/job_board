require 'rails_helper'

describe 'Posting a new job' do
  it 'posts a new job from the home page' do
    visit root_path
    within '.job-header' do
      click_on 'Post new job'
    end

    fill_in 'job_title', with: 'Senior Test Runner'
    fill_in 'job_employer_name', with: 'RSpec / Capybara inc'
    fill_in 'job_description', with: 'Red, Green, Repeat.'

    click_on 'Create Job'

    expect(page).to have_selector 'h1', text: 'Senior Test Runner'
  end
end
