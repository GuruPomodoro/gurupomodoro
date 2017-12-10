class AddNameToTeamInvitation < ActiveRecord::Migration[5.1]
  def change
    add_column :team_invitations, :name, :string
  end
end
