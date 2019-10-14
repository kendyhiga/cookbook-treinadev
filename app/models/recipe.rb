# frozen_string_literal: true

# Recipe class
class Recipe < ApplicationRecord
  belongs_to :recipe_type
  belongs_to :cuisine
  belongs_to :user
  has_many :recipe_lists, dependent: :destroy
  has_many :lists, through: :recipe_lists
  has_one_attached :image

  enum status: { pending: 0, accepted: 1, rejected: 2 }

  validates :title, :recipe_type_id, :cuisine_id, :difficulty,
            :cook_time, :ingredients, :cook_method,
            presence: true

  def cook_time_min
    "#{cook_time} minutos"
  end
end
