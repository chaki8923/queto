class Users < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :remember_token, :string
    add_column :users, :avatar, :string
  end
end
