class AddActiveToTrelloTask < ActiveRecord::Migration[5.1]
  def change
    add_column :trello_tasks, :active, :boolean
    add_index :trello_tasks, :active
  end
end
