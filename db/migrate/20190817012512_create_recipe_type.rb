class CreateRecipeType < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_types do |t|
      t.string :name
    end
  end
end
