class User < ApplicationRecord
    has_many :expusers, :dependent => :destroy
    has_many :experiments, :through => :expusers
    has_many :choices
    
  
    validates_presence_of :first_name, :last_name
    validates :email, presence: true, uniqueness: { case_sensitive: true }
    validates :password, presence: true, length: { in: 6..20 }

    has_secure_password
    
    def admin?
        self.role == 'admin'
    end
    


end
