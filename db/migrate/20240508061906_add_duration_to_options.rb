class AddDurationToOptions < ActiveRecord::Migration[7.1]
  def change
    add_column :options, :duration, :integer
  end
end
