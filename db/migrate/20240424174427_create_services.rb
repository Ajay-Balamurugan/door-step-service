class CreateServices < ActiveRecord::Migration[7.1]
  def change
    create_table :services do |t|
      t.string :title
      t.string :description
      t.string :images
      t.timestamps
    end
  end
end
