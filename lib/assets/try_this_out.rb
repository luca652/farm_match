# Made for this questio on Reddit
# https://www.reddit.com/r/rails/comments/1dpqcqf/strong_params_for_nested_params_hash/

ENV["SECRET_KEY_BASE"] = "1212312313"
ENV["DATABASE_URL"] = "sqlite3:///#{__dir__}/database.sqlite"

require "bundler/inline"

gemfile do
  source "https://www.rubygems.org"
  gem "uni_rails"
  gem "sqlite3", "~> 1.7"
  gem "byebug"
end

require "uni_rails"
require "sqlite3"
require "byebug"

#  ==== ROUTES ====
UniRails::App.routes.append do
  root 'jobs#index'
  resources :jobs do
    resource :questionnaire, only: [:edit, :update], controller: 'jobs/questionnaires'
  end
end

#  ==== DB SCHEMA ====
ActiveRecord::Base.establish_connection
ActiveRecord::Schema.define do
  create_table :jobs, force: :cascade do |t|
    t.string :title
  end

  create_table :services, force: :cascade do |t|
    t.references :job
    t.string :name
  end

  create_table :answers, force: :cascade do |t|
    t.references :service
    t.string :label
    t.integer :kind
    t.string :value
  end
end

class Job < ActiveRecord::Base
  has_many :services
  accepts_nested_attributes_for :services
end

class Service < ActiveRecord::Base
  belongs_to :job
  has_many :answers
  accepts_nested_attributes_for :answers, update_only: true
end

class Answer < ActiveRecord::Base
  belongs_to :service
  validates :label, presence: true
  enum kind: { multiple_choice: 0, multiple_choice_with_other: 1, multiple_choice_with_effect_on_next: 2, yes_no_with_optional: 3, area: 4, distance: 5, short_length: 6, long_length: 7, quantity: 8, description: 9 }.freeze

  AREA_QUESTION = {
    kind: :area,
    wording: "Estimated number of acres/hectacres?",
    options: ["acres", "hectares"],
    label: "Area"
  }

  DESCRIPTION_QUESTION = {
    kind: :description,
    wording: "Please write a short decription of the job",
    label: "Description"
  }

  QUESTIONS = {
    'Fertilizer Spreading' => [
      {
        kind: :multiple_choice,
        wording: "What type of fertilizer do you want spread?",
        label: "Type of fertilizer",
        options: ["granular", "liquid"]
      },
      AREA_QUESTION,
      DESCRIPTION_QUESTION
    ],

    'Lime Spreading' => [
      {
        kind: :multiple_choice,
        wording: "Do you need a loader?",
        options: ["yes", "no"],
        label: "Loader"
      },
      AREA_QUESTION,
      DESCRIPTION_QUESTION
    ],

    'Spraying (specialised)' => [
      {
        kind: :multiple_choice,
        wording: "What type of spraying do you require?",
        label: "Type of spraying",
        options: ["ATV spraying", "Avadex application", "Slug pelleting", "Weed wiping", "Other"]
      },
      AREA_QUESTION,
      DESCRIPTION_QUESTION
    ],
    'Spraying (standard)' => [
      {
        kind: :multiple_choice,
        wording: "What type of spraying do you require?",
        label: "Type of spraying",
        options: ["Arable spraying", "Grassland spraying"]
      },
    ]
  }
end


#  ==== SEEDS ====
# Create your existing records here

Job.create!(title: 'Job A', services_attributes: [{name: 'Fertilizer Spreading'}, {name: 'Lime Spreading'}])
Job.create!(title: 'Job B', services_attributes: [{name: 'Spraying (specialised)'}, {name: 'Spraying (standard)'}])

#  ==== HELPERS ====
module Jobs
  module QuestionnairesHelper
    def question(service, answer)
      Answer::QUESTIONS[service.name].find { |q| q[:kind].to_s == answer.kind && q[:label].to_s == answer.label }
    end
  end
end

#  ==== CONTROLLERS ====
class JobsController < ActionController::Base
  layout 'application'

  def index
    @jobs = Job.all
  end
end

module Jobs
  class QuestionnairesController < ActionController::Base
    layout 'application'

    def edit
      @job = Job.find(params[:job_id])
      @job.services.each do |service|
        next if service.answers.present?
        # multiple choice only for simplicity
        Answer::QUESTIONS[service.name].select { |question| question[:kind] == :multiple_choice }.each do |question|
          service.answers.build(
            label: question[:label],
            kind: question[:kind]
          )
        end
      end
    end

    def update
      @job = Job.find(params[:job_id])
      if @job.update(job_params)
        render :show
      else
        render :edit
      end
    end

    private

    def job_params
      params.require(:job).permit(services_attributes: [:id, answers_attributes: [:id, :label, :kind, :value]])
    end
  end
end

#  ==== CSS ====
UniRails.css <<~CSS
  html { background-color:#EEE; }
  body { width:500px; height:700px; margin:auto;
    background-color:white; padding:1rem;
  }
  form {
    input[type="submit"] { display: block; margin-top:1rem;  }
    .field_with_errors { color:red;  display:inline; }
  }
CSS

#  ==== VIEWS ====
UniRails.register_view "jobs/index.html.erb", <<~HTML
  <h1>Jobs</h1>
  <table>
    <thead>
      <tr>
        <th>Title</th>
        <th>Actions</th>
      </tr>
    </thead>
    <tbody>
      <% @jobs.each do |job| %>
        <tr>
          <td><%= job.title %></td>
          <td><%= link_to 'Answer questions', edit_job_questionnaire_path(job) %></td>
        </tr>
      <% end %>
    </tbody>
  </table>

HTML

UniRails.register_view "jobs/questionnaires/edit.html.erb", <<~HTML
  <h1>Let's get some answers</h1>
  <p class="errors"><%= @job.errors.full_messages.to_sentence %></p>
  <%= form_with model: @job, url: job_questionnaire_path do |f| %>
    <% @job.services.each do |service| %>
      <%= f.fields_for :services, service do |service_form| %>
        <fieldset>
          <h4><%= service.name %></h4>
          <%= service_form.hidden_field :id %>
          <%= service_form.fields_for :answers do |answer_form| %>
            <% question = question(service, answer_form.object) %>
            <p><%= question[:wording] %></p>
            <%= answer_form.hidden_field :id %>
            <%= answer_form.hidden_field :label %>
            <%= answer_form.hidden_field :kind %>
            <%= answer_form.collection_radio_buttons :value, question[:options], :to_s, :to_s %>
          <% end %>
        </fieldset>
      <% end %>
    <% end %>

    <%= f.submit %>
  <% end %>
HTML

UniRails.register_view "jobs/questionnaires/show.html.erb", <<~HTML
  <h1>Your answers</h1>
  <%= link_to 'Edit answers', edit_job_questionnaire_path(@job) %>
  <pre><code><%= raw JSON.pretty_generate @job.as_json(include: { services: { include: [:answers] } }) %></code></pre>
HTML

UniRails.run(Port: 3000)
