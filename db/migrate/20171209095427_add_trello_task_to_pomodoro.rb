class AddTrelloTaskToPomodoro < ActiveRecord::Migration[5.1]
  def change
    add_reference :pomodoros, :trello_task, foreign_key: true
  end
end
