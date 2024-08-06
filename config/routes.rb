Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :tasks do
    collection do
      get :new_step_one
      post :create_step_one
      get :new_step_two
      post :create_step_two
      get :new_step_three
      get :options_for_subcategory
    end

    member do
      get :edit_step_one
      patch :update_step_one
      get :edit_step_two
      patch :update_step_two
      get :edit_step_three
      get :description
      patch :update_description
      get :show_questionnaire
      patch :submit_questionnaire
    end

    resources :services
  end
  get 'options_for_question', to: 'questions#options_for_question'
end
