class Pomodoro < ApplicationRecord
  default_scope { where(is_break: false, interruption_id: nil) }

  belongs_to :user
  belongs_to :team
  belongs_to :interruption, optional: true
  belongs_to :trello_task, optional: true

  scope :without_break,      -> () { where.not(is_break: false) }
  scope :only_breaks,        -> () { unscoped.where.not(trello_id: trello_ids) }

  validates :user, presence: true
  validates :team, presence: true
  validates :started_at, presence: true
  validates :finished_at, presence: true
  validates :duration, presence: true

end
