require 'rails_helper'

RSpec.describe Job, type: :model do
  let(:user) { User.create(name: 'Marco')}
  let(:job) { Job.create!(headline: 'First Job',
                         description: 'Decent Job',
                         user_id: user.id,
                         category: 'Agri Contracting',
                         subcategory: 'Application (Spraying & Spreading)')}

  it 'has a headline' do
    expect(job.headline).to eq('First Job')
  end

  it 'has a description' do
    expect(job.description).to eq('Decent Job')
  end

  it 'belongs to a user' do
    expect(job.user).to eq(user)
  end

  it 'has a category' do
    expect(job.category).to eq('Agri Contracting')
  end

  it 'has a subcategory' do
    expect(job.subcategory).to eq('Application (Spraying & Spreading)')
  end

  describe 'validations' do
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

    it 'can be created with a valid category' do
      Job::CATEGORIES.each do |category|
        job.category = category
        job.subcategory = Job::SUBCATEGORIES[category].first
        expect(job).to be_valid
      end
    end

    # it 'cannot be created with an invalid category' do
    #   job.category = 'Some other category'
    #   expect(job).not_to be_valid
    #   expect(job.errors[:category]).to eq ["is not included in the list"]
    #   expect(job.errors[:subcategory]).to be_nil
    # end

    it 'must have a subcategory' do
      job.subcategory = nil
      expect(job).not_to be_valid
      expect(job.errors[:subcategory]).to include("can't be blank")
    end

    it 'must have a valid subcategory' do
      job.subcategory = 'Invalid Category'
      expect(job).not_to be_valid
      p job.errors
      expect(job.errors[:subcategory]).to include('is not valid for the selected category')
    end

    context "when a category is selected" do
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
end
