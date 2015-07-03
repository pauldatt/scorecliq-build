class Scoreboard < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :name_of_scoreboard, presence: true, length: { maximum: 50 }
  validates :name_of_organization, presence: true, length: { maximum: 50 }
  validates :name_of_activity, presence:true, length: { maximum: 50 }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
