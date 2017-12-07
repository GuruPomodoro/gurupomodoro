class CreateInterruptions < ActiveRecord::Migration[5.1]
  def change
    create_table :interruptions do |t|
      t.text :reason
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
