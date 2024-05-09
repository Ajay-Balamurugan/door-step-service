class MakeChangesToUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :role
    add_reference :users, :role, foreign_key: true
    add_column :users, :address, :string
    add_column :users, :phone_number, :string
    add_reference :users, :service, foreign_key: true
  end
end
