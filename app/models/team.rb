class Team < ActiveRecord::Base
  # each team is attached to a scoreboard
  belongs_to :scoreboard
end
