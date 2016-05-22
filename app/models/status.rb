class Status < ActiveRecord::Base
  belongs_to :scoreboard
  validates :content, length: {maximum: 200}
  validates :scoreboard_id, presence: true
end
