Rails.application.routes.draw do
  resources :companies do
    
    get 'company_turns_week_schedule', as: 'company_schedule'
    get 'company_engineer_turn_availabilities', as: 'edit_turn_availabilities'
    post 'update_company_engineer_turn_availabilities', as: 'update_turn_availabilities'
    
  end

  resources :engineers

  root 'engineers#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

end
