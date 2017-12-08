class CreateTrelloLists < ActiveRecord::Migration[5.1]
  def change
    create_table :trello_lists do |t|
      t.string :title
      t.string :trello_id
      t.string :trello_board_id
      t.references :team, foreign_key: true

      t.timestamps
    end
    add_index :trello_lists, :trello_id
    add_index :trello_lists, :trello_board_id
  end
end
