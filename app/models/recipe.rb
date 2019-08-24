class Recipe < ApplicationRecord
  belongs_to :recipe_type
  belongs_to :cuisine
  belongs_to :user
  has_many :recipe_lists
  has_many :lists, through: :recipe_lists

  validates :title, :recipe_type_id, :cuisine_id, :difficulty,
            :cook_time, :ingredients, :cook_method,
            presence: true

  def cook_time_min
    "#{cook_time} minutos"
  end
end
