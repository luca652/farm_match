require 'rails_helper'

RSpec.describe Service, type: :model do
  let(:user) { User.create(name: 'Marco')}
  let(:job) { Job.create!(headline: 'First Job',
                         description: 'Decent Job',
                         user_id: user.id,
                         category: 'Agri Contracting',
                         subcategory: 'Application (Spraying & Spreading)')
                        }
  let(:service) { Service.create(name: 'Fertilizer Spreading', job_id: job.id)}

  it 'has a name' do
    expect(service.name).to eq('Fertilizer Spreading')
  end

  describe 'Associations' do
    it 'belongs to a job' do
      expect(service.job).to eq(job)
    end
  end

  describe 'SERVICES' do
    it 'is a hash' do
      expect(Service::SERVICES).to be_a(Hash)
    end

    it 'has a fixed number of keys' do
      expect { Service::SERVICES['new_key'] = 'new_value' }.to raise_error(FrozenError)
    end

    it 'has frozen values that cannot be changed' do
      expect { Service::SERVICES['Drilling & Sowing'][0] = 'new_value'}.to raise_error(FrozenError)
    end

    describe 'each hash value' do
      it 'has a fixed number of elements' do
        expect {Service::SERVICES['Drilling & Sowing'] << 'new_value'}.to raise_error(FrozenError)
      end
    end
  end

  describe 'Validations' do
    it 'must have a name' do
      service.name = nil
      expect(service).not_to be_valid
      expect(service.errors[:name]).to include("can't be blank")
    end

    # it 'must have a job' do
    #   service = Service.new(name: 'Test Name')
    #   expect(service).not_to be_valid
    #   expect(service.errors).to include("Job must exist")
    # end

    context 'depending on the job it belongs to' do
      it 'can be created with an allowed name' do
        expect(service).to be_valid
      end

      it 'cannot be created with another name' do
        service.name = 'Potatoes - Drilling'
        expect(service).not_to be_valid
      end
    end

    describe '#valid_service_for_job' do

      context 'when the service is valid for the job it belongs to' do
        it 'does not return an error' do
          service.valid?
          expect(job.errors[:job]).to be_empty
        end
      end

      context 'when the service is not valid for the job it belongs to' do
        it 'returns an error' do
          service.name = 'Tree Cutting & Forestry'
          service.valid?
          expect(service.errors.full_messages).to include("Name is not valid for this job")
        end
      end
    end
  end
end
