class ChoicesController < ApplicationController
    before_action :require_user
    before_action :require_admin, only: [:index]
    before_action :no_require_admin, only: [:new, :create, :wait]
    
    def index
        @choices = Choice.all
        @participants = Experiment.last.users
        @experiment = Experiment.last
        
    end
    
    def new
        redirect_to '/experiments/index' if current_user.state == nil
        
        redirect_to '/choices/wait' if current_user.state == 2
        
        render 'new' if current_user.state == 1
    end
    
    def getinfo
        render :json =>{"ownerId" => current_user.id, "candidateList" => Experiment.last.users.where.not(:id => current_user.id), "candidateNum" => Experiment.last.users.count - Experiment.last.users.where(:id => current_user.id).count}.to_json
        
    end
    
    def create
        @preferList=params[:preferList]
        
        arr = Array.new
        1.upto(Experiment.last.users.count - Experiment.last.users.where(:id => current_user.id).count) {|x| arr << x }
        
        
        @preferList.split(",").each do |participant|
            
        @choice = Choice.create(experiment_id:Experiment.last.id, user_id:params[:ownerId], participant_id:participant, preference: arr[0], submitted: params[:type])
        
        arr.shift
        
        end
         render :json =>{ "result" => "success", "preferList" => params[:preferList],"ownerId" => params[:ownerId],"type" => params[:type]}.to_json

    end
    
    def wait
        current_user.update_attribute :state,2
        
        redirect_to '/experiments/index' if current_user.state == nil
        
        redirect_to '/choices/new' if current_user.state == 1
        
        render 'wait' if current_user.state == nil
    end



end
