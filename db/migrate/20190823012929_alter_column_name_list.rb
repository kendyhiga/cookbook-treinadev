class AlterColumnNameList < ActiveRecord::Migration[5.2]
  def change
    rename_column :lists, :string, :name
  end
end
