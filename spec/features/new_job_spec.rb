require 'rails_helper'

RSpec.describe 'New Job', js: true do

  # it 'displays a form to create a new job' do
  #   visit new_job_path

  #   expect(page).to have_selector('form#new_job')

  #   expect(page).to have_field('job_headline')
  #   expect(page).to have_field('job_description')
  #   expect(page).to have_field('job_category')
  #   expect(page).to have_field('job_subcategory')

  #   expect(page).to have_button('Create Job')
  # end

  # it 'creates a new job with valid data' do
  #   visit new_job_path
  #   fill_in 'Headline', with: 'Test Job'
  #   fill_in 'Description', with: 'This is a test job description'
  #   select 'Agri Contracting'
  #   select 'Muck & Slurry'

  #   click_button 'Create Job'
  #   expect(Job.last.id).not_to be_nil

  #   expect(page).to have_current_path(job_path(Job.last))

  #   expect(page).to have_text('Job was successfully created')
  # end
end
