class Event < ActiveRecord::Base

  belongs_to :scoreboard
  
  validates :event_name, presence: true, length: {maximum: 50}
  validates :event_date, presence: true
  validates :notes, length: {maximum: 60}
  validates :location, length: {maximum: 50}
  
end
