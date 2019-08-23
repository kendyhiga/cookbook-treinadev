class CreateRecipeLists < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_lists do |t|
      t.references :recipe, foreign_key: true
      t.references :list, foreign_key: true
    end
  end
end
