require 'rails_helper'

RSpec.describe "Jobs", type: :request do
  let(:user) { User.create(name: 'Marco')}

  describe "POST #create" do
    it 'creates a new instance of the Job class' do
      expect(job).to be_an_instance_of(Job)
    end

    it 'creates a job and saves it' do
      expect {
        post jobs_url, params: { job: {
                                 headline: 'New Job',
                                 description: 'A good job',
                                 category: 'Agri Contracting',
                                 subcategory: 'Drilling & Sowing',
                                 user_id: user.id}
                                }
      }.to change(Job, :count).by(1)
    end
  end
end
