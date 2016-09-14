class WelcomeController < ApplicationController
    before_action :require_user,only: [:join, :wait, :stop]
    before_action :no_require_admin, only: [:join, :wait, :stop]
   
   
   
    def index
    end
    
    def join
        @experiment = Experiment.last
        
        redirect_to '/welcome/stop' if current_user.state == 1
        
        redirect_to '/welcome/wait' if current_user.state == 2
        
        redirect_to '/choices/new' if current_user.state == 3
        
        redirect_to '/choices/wait' if current_user.state == 4
        
        render 'join' if current_user.state == nil
    end
    
    def wait
        @experiment = Experiment.last
        
        current_user.update_attribute :state,2
        current_user.update_attribute :role, "participant"
    end
    
    def stop
        @experiment = Experiment.last
        
        current_user.update_attribute :state,1
    end
end
