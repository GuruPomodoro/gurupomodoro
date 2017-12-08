class CreateTrelloTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :trello_tasks do |t|
      t.string :title
      t.string :trello_id
      t.references :team, foreign_key: true
      t.references :trello_list, foreign_key: true

      t.timestamps
    end
    add_index :trello_tasks, :trello_id
  end
end
