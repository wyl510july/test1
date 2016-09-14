class Experiment < ApplicationRecord
    has_many :expusers, :dependent => :destroy
    has_many :users, :through => :expusers
    has_many :choices, :dependent => :destroy
    
    validates :name, presence: true, uniqueness: { case_sensitive: true }
    validates :min, presence: true, numericality: { only_integer: true}
    validates :max, presence: true, numericality: { only_integer: true}
    validates_presence_of :description


end
