class ChangeDescriptionDataType < ActiveRecord::Migration[7.1]
  def change
    change_column :services, :description, :text
  end
end
