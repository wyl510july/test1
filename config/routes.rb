Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'welcome/index'
  
  root 'welcome#index'
  
  #routes for user
  get 'signup'  => 'users#new'
  resources :users
  
  
  #routes for login page
  get 'login'  => 'sessions#new'
  post 'login' => 'sessions#create'
  
  #routes for logout page
  delete 'logout' => 'sessions#destroy'
  
  
  #routes for experiment
  get 'experiments/index'
  get    '/experiments/new'      => "experiments#new",     :as => "new_experiment"
  post   '/experiments'          => "experiments#create",  :as => "experiments"
  
  #routes for choice
  
  get    '/choices/new'      => "choices#new",     :as => "new_choice"

end
