class AddTrelloBoardsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :trello_boards, :jsonb, default: []
  end
end
