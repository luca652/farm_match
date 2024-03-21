require 'rails_helper'

RSpec.describe 'New Job' do
  it 'displays a form to create a new job' do
    visit new_job_path

    expect(page).to have_text('New Job')

    fill_in 'Headline', with: 'Test Job'
    fill_in 'Description', with: 'This is a test job description'
    choose 'Agri Contracting'
    click_button 'Create Job'

    expect(page).to have_text('Job was successfully created.')
    expect(page).to have_text('Test Job')
    expect(page).to have_text('This is a test job description')
  end
end
