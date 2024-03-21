Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :jobs, only: [:new, :create, :show] do
    collection do
      get :subcategories
    end
  end
end
