class ChangeDescriptionTypeInOptions < ActiveRecord::Migration[7.1]
  def change
    change_column :options, :description, :text
  end
end
