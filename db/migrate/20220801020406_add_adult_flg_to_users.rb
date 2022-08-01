class AddAdultFlgToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :adult_flg, :boolean
  end
end
