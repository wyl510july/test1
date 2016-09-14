class ExperimentsController < ApplicationController
    before_action :require_user
    before_action :require_admin
    
    def index
        @participants = User.where(role: "participant");
        @experiment = Experiment.last
   
    end

    def new
        @experiment = Experiment.new
        
        redirect_to '/experiments/index' if current_user.state == 1
        
        redirect_to '/choices/index' if current_user.state == 2
        
        render 'new' if current_user.state == nil
    end
    
    def create
        @experiment = Experiment.new(allowed_params)
        if @experiment.save
            current_user.update_attribute :state,1
            redirect_to '/experiments/index', notice: "Successfully created project."
        else
            render :new
        end
    end
    
    def add
        @experiment = Experiment.last
        @participants = User.where(:role => "participant")
        
        @participants.each do |p|
            p.update_attribute :state,3
            @experiment.users << p
            
        end
        current_user.update_attribute :state,2
        redirect_to '/choices/index'
    end
    
    
    
    
    def destroy
        @experiment = Experiment.last
        
        @experiment.users.each do |user|
        user.update_attribute :state,nil
        user.update_attribute :role,nil
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
