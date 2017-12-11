class Team < ApplicationRecord
  has_many :team_users
  has_many :pomodoros
  has_many :team_leaders, -> { where user_type: 'leader' }, class_name: 'TeamUser'
  has_many :members, class_name: 'User', through: :team_users, source: :user
  has_many :leaders, class_name: 'User', through: :team_leaders, source: :user
  has_many :team_invitations
  has_many :trello_lists
  has_many :trello_tasks

  validates_associated :team_users
  validates_associated :pomodoros
  validates_associated :team_leaders
  validates_associated :members
  validates_associated :leaders
end
