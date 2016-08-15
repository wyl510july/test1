class ExperimentsController < ApplicationController
    before_action :require_user
    before_action :require_admin, only: [:new, :create]
    before_action :no_require_admin, only: [:index]
    
    def index
        redirect_to '/choices/new' if current_user.state == 1
        
        redirect_to '/choices/wait' if current_user.state == 2


        render 'index' if current_user.state == nil
  
    end

    def new
        @experiment = Experiment.new
        
        if current_user.state == 4
            redirect_to '/choices/index'
        else
            @experiment = Experiment.new
            render 'new'
        end
    end
    
    def create
        @experiment = Experiment.new(allowed_params)
        if @experiment.save
            current_user.update_attribute :state,4
            redirect_to '/choices/index', notice: "Successfully created project."
        else
            render :new
        end
    end
    
    
    def destroy
        @experiment = Experiment.last
        
        @experiment.users.each do |user|
        user.update_attribute :state,nil
        end
        
        @experiment.destroy
        
        current_user.update_attribute :state,nil
        redirect_to '/experiments/new'
    end
    
    private
    
    def allowed_params
        params.require(:experiment).permit!
    end
    
end
