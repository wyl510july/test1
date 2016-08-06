class Expuser < ApplicationRecord
    belongs_to :experiment
    belongs_to :user
    
    has_many :choices
end
