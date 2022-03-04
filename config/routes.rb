Rails.application.routes.draw do
  root "categories#index"

  devise_for :users

  get "tasks", to: "tasks#index"

  resources :categories do
    resources :tasks, except: :index
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
