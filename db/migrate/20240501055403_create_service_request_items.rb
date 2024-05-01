class CreateServiceRequestItems < ActiveRecord::Migration[7.1]
  def change
    create_table :service_request_items do |t|
      t.references :service_request, null: false, foreign_key: true
      t.references :option, null: false, foreign_key: true
      t.datetime :time_slot
      t.integer :status
      t.string :otp_secret_key

      t.timestamps
    end
  end
end
