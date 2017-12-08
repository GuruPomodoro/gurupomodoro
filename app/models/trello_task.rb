class TrelloTask < ApplicationRecord
  default_scope { where(active: true) }

  belongs_to :team
  belongs_to :trello_list

  scope :without_trello_ids,           -> (trello_ids) { where.not(trello_id: trello_ids) }

end
