class TeamUser < ApplicationRecord
  belongs_to :team
  belongs_to :user

  validates :team, presence: true
  validates :user, presence: true
  validates :user_type, presence: true
end
