class AddTrelloBoardIdToTeam < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :trello_board_id, :string
  end
end
