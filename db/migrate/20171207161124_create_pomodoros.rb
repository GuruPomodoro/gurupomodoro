class CreatePomodoros < ActiveRecord::Migration[5.1]
  def change
    create_table :pomodoros do |t|
      t.references :user, foreign_key: true
      t.references :team, foreign_key: true
      t.datetime :started_at
      t.datetime :finished_at
      t.references :interruption, foreign_key: true
      t.integer :duration
      t.boolean :is_break

      t.timestamps
    end
  end
end
