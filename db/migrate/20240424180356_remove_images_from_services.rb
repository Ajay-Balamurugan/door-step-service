class RemoveImagesFromServices < ActiveRecord::Migration[7.1]
  def change
    remove_column :services, :images, :string
  end
end
