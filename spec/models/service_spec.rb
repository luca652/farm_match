require 'rails_helper'

RSpec.describe Service, type: :model do
  let(:user) { User.create(name: 'Marco')}
  let(:job) { Job.create(headline: 'First Job',
                         description: 'Decent Job',
                         user_id: user.id,
                         category: 'Agri Contracting',
                         subcategory: 'Application (Spraying & Spreading)')}
  let(:service) { Service.new(job_id: job.id, name: 'Fertilizer Spreading')}

  it 'has a name' do
    expect(service.name).to eq('Fertilizer Spreading')
  end
end
