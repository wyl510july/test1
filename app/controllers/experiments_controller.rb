class ExperimentsController < ApplicationController
    before_action :require_user
    before_action :require_admin, only: [:new, :create]
    before_action :no_require_admin, only: [:index]
    
    def index
        
    end

    def new
        @experiment = Experiment.new
    end
    
    def create
        @experiment = Experiment.new(allowed_params)
        if @experiment.save
            redirect_to '/', notice: "Successfully created project."
            else
            render :new
        end
    end
    

    
    private
    
    def allowed_params
        params.require(:experiment).permit!
    end
end
