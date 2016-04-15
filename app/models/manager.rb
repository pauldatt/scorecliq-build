class Manager < ActiveRecord::Base
    belongs_to :scoreboard
    belongs_to :user
end
