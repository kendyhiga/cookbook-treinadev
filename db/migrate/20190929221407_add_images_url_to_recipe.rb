class AddImagesUrlToRecipe < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :image_url, :string
  end
end
