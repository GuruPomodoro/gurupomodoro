class CreateTeamInvitations < ActiveRecord::Migration[5.1]
  def change
    create_table :team_invitations do |t|
      t.references :from, index: true, foreign_key: { to_table: :users }
      t.references :team, foreign_key: true
      t.string :to_email
      t.string :to_name
      t.datetime :accepted_at

      t.timestamps
    end
  end
end
