class UsersController < ApplicationController
    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to '/', notice: "Successfully created user."
            else
            render :new
        end
    end
    
    def update
        @participant = User.find(params[:id])
        @participant.update_attribute :role,nil
        @participant.update_attribute :state,1
        redirect_to '/experiments/index'
    end
    
    
    private
    def user_params
        params.require(:user).permit!
    end
end
