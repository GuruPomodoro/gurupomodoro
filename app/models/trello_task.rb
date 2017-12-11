class TrelloTask < ApplicationRecord
  default_scope { where(active: true) }

  belongs_to :team
  belongs_to :trello_list

  has_many :pomodoros

  scope :without_trello_ids,           -> (trello_ids) { where.not(trello_id: trello_ids) }

  validates :trello_list, presence: true
  validates :team, presence: true
  validates_associated :pomodoros
  validates :trello_id, presence: true
  validates :team_id, presence: true
  validates :trello_list_id, presence: true

end
