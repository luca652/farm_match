require 'rails_helper'

RSpec.describe Service, type: :model do
  let(:user) { create(:user) }
  let(:task) { create(:task, user: user) }
  let(:service) { task.services.first }

  describe 'Attributes' do
    it 'has a name' do
      expect(task.services.first.name).to be_in(Service::SERVICES['Application (Spraying & Spreading)'])
    end
  end


  describe 'Associations' do
    it 'belongs to a task' do
      expect(service.task).to eq(task)
    end

    it 'belongs to a task' do
      task = create(:task)
      service = task.services.first
      expect(service.task).to eq(task)
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

  describe 'validations' do
    it 'must have a name' do
      service.name = nil
      expect(service).not_to be_valid
      expect(service.errors[:name]).to include("can't be blank")
    end

    it 'is valid with a valid name for the task subcategory' do
      task = build(:task, subcategory: 'Application (Spraying & Spreading)')
      service = task.services.first
      expect(service).to be_valid
    end

    it 'is invalid with an invalid name for the task subcategory' do
      task = build(:task, subcategory: 'Application (Spraying & Spreading)')
      service = build(:service, task: task, name: 'Cereals - Drilling')
      task.services << service
      expect(service).to be_invalid
      expect(service.errors[:name]).to include("is not valid for this task")
    end

    it 'prevents creation of service with duplicate name for a task' do
      task = create(:task)
      existing_service_name = task.services.first.name
      duplicate_service = build(:service, task: task, name: existing_service_name)

      expect(duplicate_service).to be_invalid
      expect(duplicate_service.errors[:name]).to include("should be unique for the task")
    end

    context 'depending on the task it belongs to' do
      it 'can be created with an allowed name' do
        expect(service).to be_valid
      end

      it 'cannot be created with another name' do
        service.name = 'Potatoes - Drilling'
        expect(service).not_to be_valid
      end
    end

    describe '#valid_service_for_task' do

      context 'when the service is valid for the task it belongs to' do
        it 'does not return an error' do
          service.valid?
          expect(task.errors[:task]).to be_empty
        end
      end

      context 'when the service is not valid for the task it belongs to' do
        it 'returns an error' do
          service.name = 'Tree Cutting & Forestry'
          service.valid?
          expect(service.errors.full_messages).to include("Name is not valid for this task")
        end
      end
    end
  end

  describe 'valid services for different subcategories' do
    it 'allows valid service for Drilling & Sowing' do
      task = build(:task, subcategory: 'Drilling & Sowing')
      task.services.clear
      service = build(:service, task: task, name: 'Cereals - Drilling')
      task.services << service
      expect(service).to be_valid
    end

    it 'allows valid service for Fencing & Hedging' do
      task = build(:task, subcategory: 'Fencing & Hedging')
      task.services.clear
      service = build(:service, task: task, name: 'Fence Erection')
      task.services << service
      expect(service).to be_valid
    end
  end
end
