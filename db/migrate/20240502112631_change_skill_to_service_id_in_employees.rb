class ChangeSkillToServiceIdInEmployees < ActiveRecord::Migration[7.1]
  def change
    remove_column :employees, :skill, :string
    add_reference :employees, :service, foreign_key: true
  end
end
