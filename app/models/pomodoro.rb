class Pomodoro < ApplicationRecord
  default_scope { where(is_break: false, interruption_id: nil) }

  belongs_to :user
  belongs_to :team
  belongs_to :interruption, optional: true
  belongs_to :trello_task, optional: true

  scope :without_break,      -> () { where.not(is_break: false) }
  scope :only_breaks,        -> () { unscoped.where.not(trello_id: trello_ids) }
end
