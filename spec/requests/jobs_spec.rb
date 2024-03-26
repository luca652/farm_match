require 'rails_helper'

RSpec.describe "Jobs", type: :request do
  let(:user) { User.create(name: 'Marco')}
  let(:job_params) do
     {
      job: {
        headline: 'New Job',
        description: 'A good job',
        category: 'Agri Contracting',
        subcategory: 'Drilling and Sowing',
        user_id: user.id
      }
    }
  end
  let(:job) { Job.new(job_params[:job])}

  describe "POST #create" do
    it 'creates a new instance of the Job class' do
      expect(job).to be_an_instance_of(Job)
    end

    it 'creates a job and saves it' do
      expect {
        post jobs_url, params: job_params}.to change(Job, :count).by(1)
    end

    it 'returns a successful response' do
      post jobs_url, params: job_params
      expect(response).to have_http_status(:found)
    end

    it 'redirects to the correct path after job creation' do
      post jobs_url, params: job_params
      expect(response).to redirect_to(job_path(Job.last))
    end
  end
end
