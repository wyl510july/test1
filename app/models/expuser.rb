class Expuser < ApplicationRecord
    belongs_to :experiment
    belongs_to :user

end
