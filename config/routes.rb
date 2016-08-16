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
  delete '/experiments/:id'      => "experiments#destroy", :as => "experiment"
  
  #routes for choice
  
  get 'choices/index'
  
  
  get '/choices/new'
  
  get '/choices/getinfo' => "choices#getinfo"
  
  get '/choices/create'=> "choices#create"
  
  get 'choices/wait'

end
