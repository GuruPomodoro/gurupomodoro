class CreateTeamUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :team_users do |t|
      t.references :team, foreign_key: true
      t.references :user, foreign_key: true
      t.string :user_type

      t.timestamps
    end
  end
end
