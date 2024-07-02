require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  let(:user) { User.create(name: 'Marco')}
  let(:task_params) do
     {
      task: {
        headline: 'New Task',
        description: 'A good task',
        category: 'Agri Contracting',
        subcategory: 'Application (Spraying & Spreading)',
        user_id: user.id
      }
    }
  end
  let(:task) { Task.new(task_params[:task])}
  let(:service) { Service.new(task_id: task.id, name: 'Fertilizer Spreading' ) }

  describe "POST #create" do
    it 'creates a new instance of the task class' do
      expect(task).to be_an_instance_of(task)
    end

    it 'creates a task & saves it' do
      expect {
        post tasks_url, params: task_params}.to change(task, :count).by(1)
    end

    it 'returns a successful response' do
      post tasks_url, params: task_params
      expect(response).to have_http_status(:found)
    end

  end
end
