require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:user) { User.create(name: 'Marco')}
  let(:task) { Task.create!(headline: 'First Task',
                         description: 'Decent Task',
                         user_id: user.id,
                         category: 'Agri Contracting',
                         subcategory: 'Application (Spraying & Spreading)')
                        }
  let(:service) { Service.create(name: 'Fertilizer Spreading', task_id: task.id)}
  let(:answer) { Answer.create(answer: "Yes", label: "Test Label", service_id: service.id)}

  it 'has an answer' do
    expect(answer.answer).to eq("Yes")
  end

  it 'has a label' do
    expect(answer.label).to eq("Test Label")
  end

  describe 'Associations' do
    it 'belongs to a service' do
      expect(answer.service).to eq(service)
    end
  end

  describe 'Validations' do
    it 'must have an answer' do
      answer.answer = nil
      expect(answer).not_to be_valid
      expect(answer.errors[:answer]).to eq(["can't be blank"])
    end

    it 'must have a label' do
      answer.label = nil
      expect(answer).not_to be_valid
      expect(answer.errors[:label]).to eq(["can't be blank"])
    end
  end
end
