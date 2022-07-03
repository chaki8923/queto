class Authors < ActiveRecord::Migration[6.1]
  def change
    drop_table :authors
  end
end
