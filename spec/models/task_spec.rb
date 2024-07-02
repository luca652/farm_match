require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:user) { User.create(name: 'Marco')}
  let(:task) { Task.create!(headline: 'First task',
                         description: 'Decent task',
                         user_id: user.id,
                         category: 'Agri Contracting',
                         subcategory: 'Application (Spraying & Spreading)')
                        }
  let(:service) { Service.create(name: 'Fertilizer Spreading', task_id: task.id)}

  it 'has a headline' do
    expect(task.headline).to eq('First task')
  end

  it 'has a description' do
    expect(task.description).to eq('Decent task')
  end

  it 'has a category' do
    expect(task.category).to eq('Agri Contracting')
  end

  it 'has a subcategory' do
    expect(task.subcategory).to eq('Application (Spraying & Spreading)')
  end

  describe 'Associations' do
    it 'belongs to a user' do
      expect(task.user).to eq(user)
    end

    it 'has many services' do
      expect(task).to respond_to(:services)
    end
  end


  describe 'Categories' do
    it 'is an array' do
      expect(Task::CATEGORIES).to be_an(Array)
    end

    it 'cannot be changed' do
      expect { Task::CATEGORIES[0] = 'new_category' }.to raise_error(FrozenError)
    end

    it 'contains strings that cannot be changed' do
      expect { Task::CATEGORIES[0].upcase! }.to raise_error(FrozenError)
    end
  end

  describe 'Subcategories' do
    it 'is a hash' do
      expect(Task::SUBCATEGORIES).to be_a(Hash)
    end

    it 'has categories as keys' do
      keys = Task::SUBCATEGORIES.keys
      keys.each do |key|
        expect(Task::CATEGORIES).to include(key)
      end
    end

    it 'has fixed categories' do
      expect { Task::SUBCATEGORIES['new_category'] = 'new_subcategory'}.to raise_error(FrozenError)
    end

    it 'contains values that cannot be changed' do
      expect { Task::SUBCATEGORIES['Agri Contracting'][0] = 'new_subcategory'}.to raise_error(FrozenError)
    end
  end

  describe 'Validations' do
    it 'must have a headline' do
      task.headline = nil
      expect(task).not_to be_valid
      expect(task.errors[:headline]).to include("can't be blank")
    end

    it 'must have a description' do
      task.description = nil
      expect(task).not_to be_valid
      expect(task.errors[:description]).to eq ["can't be blank"]
    end

    it 'must have a user' do
      task.user = nil
      expect(task).not_to be_valid
      expect(task.errors[:user]).to eq ["must exist"]
    end

    it 'must have a category' do
      task.category = nil
      expect(task).not_to be_valid
      expect(task.errors[:category]).to include("can't be blank")
    end

    # it 'can be created with a valid category' do
    #   Task::CATEGORIES.each do |category|
    #     task.category = category
    #     task.subcategory = Task::SUBCATEGORIES[category].first
    #     expect(task).to be_valid
    #   end
    # end

    it 'cannot be created with an invalid category' do
      task = Task.new(headline: 'Invalid task', description: 'This task is not valid', user_id: user.id)
      task.category = 'Some invalid category'
      expect(task).not_to be_valid
      expect(task.errors[:category]).to eq ["is not included in the list"]
    end

    it 'must have a subcategory' do
      task.subcategory = nil
      expect(task).not_to be_valid
      expect(task.errors[:subcategory]).to include("can't be blank")
    end

    it 'must have a valid subcategory' do
      task.subcategory = 'Invalid Category'
      expect(task).not_to be_valid
      expect(task.errors[:subcategory]).to include('is not valid for the selected category')
    end

    context "When a category is selected" do
      it 'requires a subcategory nested under that category' do
        category = Task::CATEGORIES[0]
        not_nested_subcategory = Task::SUBCATEGORIES[Task::CATEGORIES[1]].first

        task.category = category
        task.subcategory = not_nested_subcategory
        expect(task).not_to be_valid
        expect(task.errors[:subcategory]).to eq ['is not valid for the selected category']
      end
    end
  end

  describe '#valid_subcategory_for_category' do
    it 'does not return an error if the subcategory is valid for the selected category' do
      task.valid?
      expect(task.errors[:subcategory]).to be_empty
    end

    it 'does return an error if the subcategory is not valid for the selected category' do
      task.subcategory = 'Tree Cutting and Forestry'
      task.valid?
      expect(task.errors[:subcategory]).to include("is not valid for the selected category")
    end
  end


end
