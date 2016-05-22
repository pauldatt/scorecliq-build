class Event < ActiveRecord::Base
  belongs_to :scoreboard
  
  validates :event_name, presence: true, length: {maximum: 30}
  validates :event_date, presence: true
  validates :event_time, presence: true
  validates :notes, presence: true, length: {maximum: 140}
  
end
