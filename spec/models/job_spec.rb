require 'rails_helper'

RSpec.describe Job, type: :model do
  let(:user) { User.create(name: 'Marco')}
  let(:job) { Job.create(headline: 'First Job',
                         description: 'Decent Job',
                         user_id: user.id,
                         category: 'Agri Contracting',
                         subcategory: 'Application (Spraying and Spreading)',
                         services_attributes: [{ name: 'Fertilizer Spreading' }])
                        }
  let(:service) { job.services.first }

  it 'has a headline' do
    expect(job.headline).to eq('First Job')
  end

  it 'has a description' do
    expect(job.description).to eq('Decent Job')
  end

  it 'has a category' do
    expect(job.category).to eq('Agri Contracting')
  end

  it 'has a subcategory' do
    expect(job.subcategory).to eq('Application (Spraying and Spreading)')
  end

  describe 'Associations' do
    it 'belongs to a user' do
      expect(job.user).to eq(user)
    end

    it 'has many services' do
      expect(job).to respond_to(:services)
    end
  end


  describe 'Categories' do
    it 'is an array' do
      expect(Job::CATEGORIES).to be_an(Array)
    end

    it 'cannot be changed' do
      expect { Job::CATEGORIES[0] = 'new_category' }.to raise_error(FrozenError)
    end

    it 'contains strings that cannot be changed' do
      expect { Job::CATEGORIES[0].upcase! }.to raise_error(FrozenError)
    end
  end

  describe 'Subcategories' do
    it 'is a hash' do
      expect(Job::SUBCATEGORIES).to be_a(Hash)
    end

    it 'has categories as keys' do
      keys = Job::SUBCATEGORIES.keys
      keys.each do |key|
        expect(Job::CATEGORIES).to include(key)
      end
    end

    it 'has fixed categories' do
      expect { Job::SUBCATEGORIES['new_category'] = 'new_subcategory'}.to raise_error(FrozenError)
    end

    it 'contains values that cannot be changed' do
      expect { Job::SUBCATEGORIES['Agri Contracting'][0] = 'new_subcategory'}.to raise_error(FrozenError)
    end
  end

  describe 'Validations' do
    it 'must have a headline' do
      job.headline = nil
      expect(job).not_to be_valid
      expect(job.errors[:headline]).to include("can't be blank")
    end

    it 'must have a description' do
      job.description = nil
      expect(job).not_to be_valid
      expect(job.errors[:description]).to eq ["can't be blank"]
    end

    it 'must have a user' do
      job.user = nil
      expect(job).not_to be_valid
      expect(job.errors[:user]).to eq ["must exist"]
    end

    it 'must have a category' do
      job.category = nil
      expect(job).not_to be_valid
      expect(job.errors[:category]).to include("can't be blank")
    end

    # it 'can be created with a valid category' do
    #   Job::CATEGORIES.each do |category|
    #     job.category = category
    #     job.subcategory = Job::SUBCATEGORIES[category].first
    #     expect(job).to be_valid
    #   end
    # end

    it 'cannot be created with an invalid category' do
      job = Job.new(headline: 'Invalid Job', description: 'This job is not valid', user_id: user.id)
      job.category = 'Some invalid category'
      expect(job).not_to be_valid
      expect(job.errors[:category]).to eq ["is not included in the list"]
    end

    it 'must have a subcategory' do
      job.subcategory = nil
      expect(job).not_to be_valid
      expect(job.errors[:subcategory]).to include("can't be blank")
    end

    it 'must have a valid subcategory' do
      job.subcategory = 'Invalid Category'
      expect(job).not_to be_valid
      expect(job.errors[:subcategory]).to include('is not valid for the selected category')
    end

    context "When a category is selected" do
      it 'requires a subcategory nested under that category' do
        category = Job::CATEGORIES[0]
        not_nested_subcategory = Job::SUBCATEGORIES[Job::CATEGORIES[1]].first

        job.category = category
        job.subcategory = not_nested_subcategory
        expect(job).not_to be_valid
        expect(job.errors[:subcategory]).to eq ['is not valid for the selected category']
      end
    end
  end

  describe '#valid_subcategory_for_category' do
    it 'does not return an error if the subcategory is valid for the selected category' do
      job.valid?
      expect(job.errors[:subcategory]).to be_empty
    end

    it 'does return an error if the subcategory is not valid for the selected category' do
      job.subcategory = 'Tree Cutting and Forestry'
      job.valid?
      expect(job.errors[:subcategory]).to include("is not valid for the selected category")
    end
  end


end
