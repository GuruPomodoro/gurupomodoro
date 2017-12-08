class TrelloList < ApplicationRecord
  belongs_to :team
  has_many :trello_tasks, dependent: :nullify

  scope :with_trello_board_id,           -> (trello_board_id) { where(trello_board_id: trello_board_id) }
  scope :without_trello_ids,           -> (trello_ids) { where.not(trello_id: trello_ids) }
end
