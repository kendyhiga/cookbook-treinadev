class Recipe < ApplicationRecord
  validates :title, :recipe_type, :cuisine, :difficulty,
            :cook_time, :ingredients, :cook_method,
            presence: true

  def cook_time_min
    "#{cook_time} minutos"
  end
end
