Rails.application.routes.draw do
  root "homes#index"

  devise_for :users

  get "tasks", to: "tasks#index"
  get "tasks/overdue", to: "tasks#overdue"
  get "tasks/after_today", to: "tasks#after_today"

  resources :categories do
    resources :tasks, except: :index
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
