class Experiment < ApplicationRecord
    has_many :expusers, :dependent => :destroy
    has_many :users, :through => :expusers
    
    
    validates :min, presence: true, numericality: { only_integer: true}
    validates :max, presence: true, numericality: { only_integer: true}
    validates_presence_of :description, :email_list
    
    attr_writer:email_list
    before_save :assign_users
    
    def email_list
        @email_list || users.map(&:email).join(' ')
    end
    


    private
    def assign_users
        if @email_list
            @email_list.split(/\s+/).map do |e|
                if User.exists?(email: e)
                self.users << User.find_by(email: e)
                end
            end
        end
    end

end
