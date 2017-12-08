class AddActiveToTrelloList < ActiveRecord::Migration[5.1]
  def change
    add_column :trello_lists, :active, :boolean
    add_index :trello_lists, :active
  end
end
