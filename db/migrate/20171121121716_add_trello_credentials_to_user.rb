class AddTrelloCredentialsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :trello_token, :string
    add_column :users, :trello_secret, :string
  end
end
