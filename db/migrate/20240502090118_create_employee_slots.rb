class CreateEmployeeSlots < ActiveRecord::Migration[7.1]
  def change
    create_table :employee_slots do |t|
      t.references :employee, null: false, foreign_key: true
      t.references :service_request_item, null: false, foreign_key: true
      t.datetime :time_slot

      t.timestamps
    end
  end
end
