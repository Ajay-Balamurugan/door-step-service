class RemoveEmployeeIdFromEmployeeSlots < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :employee_slots, :employees

    remove_column :employee_slots, :employee_id, :bigint

    add_column :employee_slots, :user_id, :bigint, null: false

    add_foreign_key :employee_slots, :users
  end
end
